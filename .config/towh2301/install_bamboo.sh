#!/bin/bash
set -e

echo "=== Install fcitx5 + bamboo (Fedora / Hyprland) ==="

# ================================
# 1. Install dependencies (runtime + devel)
# ================================
echo "[1/5] Installing dependencies..."
sudo dnf install -y \
  fcitx5 \
  fcitx5-devel \
  fcitx5-qt \
  fcitx5-qt-devel \
  fcitx5-gtk \
  fcitx5-gtk-devel \
  fcitx5-configtool \
  cmake \
  extra-cmake-modules \
  golang \
  libX11-devel \
  wayland-devel \
  gcc-c++ \
  make

# ================================
# 2. Prepare source directory
# ================================
WORKDIR="$HOME/.local/src"
mkdir -p "$WORKDIR"
cd "$WORKDIR"

# ================================
# 3. Clone / update repositories
# ================================
echo "[2/5] Cloning repositories..."

if [ ! -d "fcitx5-bamboo" ]; then
  git clone https://github.com/fcitx/fcitx5-bamboo.git
else
  cd fcitx5-bamboo && git pull && cd ..
fi

if [ ! -d "bamboo-core" ]; then
  git clone https://github.com/BambooEngine/bamboo-core.git
fi

# ================================
# 4. Build & install fcitx5-bamboo
# ================================
echo "[3/5] Building fcitx5-bamboo..."

rm -rf fcitx5-bamboo/build
mkdir -p fcitx5-bamboo/bamboo
cp -r bamboo-core fcitx5-bamboo/bamboo/

cd fcitx5-bamboo
mkdir build
cd build

cmake -DCMAKE_INSTALL_PREFIX=/usr ..
make -j$(nproc)
sudo make install

# ================================
# 5. Hyprland config
# ================================
echo "[4/5] Configuring Hyprland..."

HYPR_CONF="$HOME/.config/hypr/hyprland.conf"
mkdir -p "$(dirname "$HYPR_CONF")"

grep -q "fcitx5 -d" "$HYPR_CONF" 2>/dev/null || cat <<EOF >>"$HYPR_CONF"

# ---- Fcitx5 ----
exec-once = fcitx5 -d
EOF

# Environment variables (Wayland safe)
PROFILE="$HOME/.profile"
grep -q "GTK_IM_MODULE=fcitx5" "$PROFILE" 2>/dev/null || cat <<EOF >>"$PROFILE"

# ---- Fcitx5 ----
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5
export SDL_IM_MODULE=fcitx5
export GLFW_IM_MODULE=fcitx5
EOF

echo "[5/5] Done ✅"
echo ""
echo "👉 Log out & log in again"
echo "👉 Run: fcitx5-configtool"
echo "👉 Add input method: Bamboo"
