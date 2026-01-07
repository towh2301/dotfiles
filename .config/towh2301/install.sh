#!/usr/bin/env bash
set -euo pipefail
# ==============================================================================
# Full-Stack + C/C++ Dev Environment (Fedora 43 - December 2025)
# Optimized for mid-range hardware (e.g., i5 Gen 8 / 16GB RAM / SSD)
# Idempotent • Non-interactive • CLI-first
# ==============================================================================


# Quickshell with DankMaterialLinux
# curl -fsSL https://install.danklinux.com | sh

# ------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------
log() { echo -e "\n\033[1;32m==> $1\033[0m"; }
skip() { echo -e "\033[1;33m⊙ Skipping: $1 (already installed/configured)\033[0m"; }
backup_dir() {
  local target="$1"
  if [ -e "$target" ]; then
    mv "$target" "${target}.backup.$(date +%s)"
  fi
}

# ------------------------------------------------------------------------------
# Base system update
# ------------------------------------------------------------------------------

# Fedora DNF package manager NERD Fonts
log "Updating system"
sudo dnf update -y --refresh
sudo dnf upgrade -y

sudo dnf install openssl nautilus git curl wget neovim -y

log "Installing Nerd Fonts"
NERD_FONTS_DIR="$HOME/.local/share/fonts"
mkdir -p "$NERD_FONTS_DIR"

if ! fc-list | grep -q "Hack Nerd Font"; then
  log "Installing Hack Nerd Font"
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/install.sh)" Hack
else
  skip "Hack Nerd Font already installed"
fi

if ! fc-list | grep -q "FiraCode Nerd Font"; then
 log "Installing FiraCode Nerd Font"
 bash -c "$(curl -fsSL https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/install.sh)" FiraCode
else
 skip "FiraCode Nerd Font already installed"
fi

fc-cache -f -v

# Install Kitty terminal emulator
if ! command -v kitty >/dev/null; then
  log "Installing Kitty"
  sudo dnf install -y kitty
else
  skip "Kitty already installed"
fi

# Install Ghostty terminal multiplexer
if ! command -v ghostty >/dev/null; then
  log "Installing Ghostty (via COPR)"
  sudo dnf copr enable quintiliano/ghostty -y
  sudo dnf install -y ghostty
else
  skip "Ghostty already installed"
fi

# ------------------------------------------------------------------------------
# Development Tools Groups (modern Fedora/dnf5 compatible)
# ------------------------------------------------------------------------------
log "Installing development tool groups"
DEV_GROUPS=("development-tools" "c-development")
INSTALLED_GROUPS=$(dnf group list --installed 2>/dev/null | awk '{print $1}' || true)

TO_INSTALL=()
for group_id in "${DEV_GROUPS[@]}"; do
  if ! echo "$INSTALLED_GROUPS" | grep -q "^$group_id"; then
    TO_INSTALL+=("$group_id")
  fi
done

if [ ${#TO_INSTALL[@]} -gt 0 ]; then
  sudo dnf group install -y "${TO_INSTALL[@]}"
else
  skip "Development tool groups already installed"
fi

# ------------------------------------------------------------------------------
# Visual Studio Code
# ------------------------------------------------------------------------------
if ! command -v code >/dev/null; then
  log "Installing Visual Studio Code"
  if [ ! -f /etc/yum.repos.d/vscode.repo ]; then
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo >/dev/null
    sudo dnf check-update
  fi
  sudo dnf install -y code
else
  skip "Visual Studio Code already installed"
fi

# ------------------------------------------------------------------------------
# GNU Stow
# ------------------------------------------------------------------------------
if ! command -v stow >/dev/null; then
  log "Installing GNU Stow"
  sudo dnf install -y stow
else
  skip "GNU Stow already installed"
fi


# ------------------------------------------------------------------------------
# C/C++ Core packages
# ------------------------------------------------------------------------------
log "Installing C/C++ development stack"
CPP_PKGS=(
  clang clang-tools-extra lldb
  gdb valgrind strace ltrace
  cmake ninja-build meson
  pkg-config
  boost-devel
  gtest-devel gmock-devel
  catch2-devel # Updated package name in recent Fedora
  fmt-devel
  spdlog-devel
  nlohmann-json-devel
  sqlite-devel
  libcurl-devel
  openssl-devel
  zlib-devel
  readline-devel
)

TO_INSTALL=()
for pkg in "${CPP_PKGS[@]}"; do
  if ! rpm -q "$pkg" >/dev/null 2>&1; then
    TO_INSTALL+=("$pkg")
  fi
done

if [ ${#TO_INSTALL[@]} -gt 0 ]; then
  sudo dnf install -y "${TO_INSTALL[@]}"
else
  skip "All C/C++ packages already installed"
fi

# ------------------------------------------------------------------------------
# Core CLI utilities
# ------------------------------------------------------------------------------
log "Installing core CLI utilities"
CORE_PKGS=(
  ca-certificates curl wget gnupg
  unzip zip fd-find ripgrep fzf htop tree
  git python3 python3-pip pipx
  postgresql mysql redis # Clients/servers; use -devel if only headers needed
  zsh alacritty
)

TO_INSTALL=()
for pkg in "${CORE_PKGS[@]}"; do
  if ! rpm -q "$pkg" >/dev/null 2>&1; then
    TO_INSTALL+=("$pkg")
  fi
done

if [ ${#TO_INSTALL[@]} -gt 0 ]; then
  sudo dnf install -y "${TO_INSTALL[@]}"
else
  skip "All core packages already installed"
fi

# fd symlink (fd-find package provides fdfind)
if command -v fdfind >/dev/null && [ ! -L /usr/local/bin/fd ]; then
  sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
elif command -v fd >/dev/null; then
  skip "fd already available"
fi

# ------------------------------------------------------------------------------
# vcpkg (C++ Package Manager)
# ------------------------------------------------------------------------------
VCPKG_DIR="$HOME/.local/vcpkg"
if [ ! -d "$VCPKG_DIR" ]; then
  log "Installing vcpkg"
  git clone https://github.com/microsoft/vcpkg.git "$VCPKG_DIR"
  "$VCPKG_DIR/bootstrap-vcpkg.sh"
  echo 'export PATH="$HOME/.local/vcpkg:$PATH"' >>"$HOME/.zshrc"
else
  skip "vcpkg already installed"
fi

# ------------------------------------------------------------------------------
# Conan (C++ Package Manager - alternative)
# ------------------------------------------------------------------------------
if ! command -v conan >/dev/null; then
  log "Installing Conan"
  python3 -m pip install --user conan
  echo 'export PATH="$HOME/.local/bin:$PATH"' >>"$HOME/.zshrc"
else
  skip "Conan already installed"
fi

# ------------------------------------------------------------------------------
# Zsh + plugins + Starship
# ------------------------------------------------------------------------------
if [ "$SHELL" != "$(which zsh)" ]; then
  log "Setting Zsh as default shell"
  sudo chsh -s "$(which zsh)" "$USER"
else
  skip "Zsh already default shell"
fi

ZSH_CUSTOM="$HOME/.config/zsh"
mkdir -p "$ZSH_CUSTOM/plugins"

git_clone() {
  local repo="$1" dest="$2"
  if [ -d "$dest" ]; then
    skip "$(basename "$dest") plugin"
    return 0
  fi
  git clone --depth=1 "$repo" "$dest"
}

git_clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git_clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git_clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"


backup_dir "$HOME/.zshrc"
cat >"$HOME/.zshrc" <<'EOF'
export ZDOTDIR="$HOME"
export ZSH_CUSTOM="$HOME/.config/zsh"

fpath+=("$ZSH_CUSTOM/plugins/zsh-completions/src")
source "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
autoload -Uz compinit && compinit

# NVM
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# vcpkg + user bins
export PATH="$HOME/.local/vcpkg:$HOME/.local/bin:$PATH"
EOF

# FZF integration
echo '# FZF' >>"$HOME/.zshrc"
echo '[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh' >>"$HOME/.zshrc"
echo '[ -f /usr/share/fzf/shell/completion.zsh ] && source /usr/share/fzf/shell/completion.zsh' >>"$HOME/.zshrc"
echo 'export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob \"!.git/*\""' >>"$HOME/.zshrc"

# ------------------------------------------------------------------------------
# Neovim
# ------------------------------------------------------------------------------
if ! command -v nvim >/dev/null; then
  log "Installing Neovim"
  sudo dnf install -y neovim
else
  skip "Neovim already installed"
fi

if [ ! -d "$HOME/.config/nvim/.git" ]; then
  log "Cloning Neovim LazyVim config"
  backup_dir "$HOME/.config/nvim"
  git clone https://github.com/towh2301/nvim "$HOME/.config/nvim"
else
  skip "Neovim config already exists"
fi

# ------------------------------------------------------------------------------
# Node.js via NVM
# ------------------------------------------------------------------------------
export NVM_DIR="$HOME/.config/nvm"
mkdir -p "$NVM_DIR"

if [ ! -s "$NVM_DIR/nvm.sh" ]; then
  log "Installing NVM"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
else
  skip "NVM already installed"
fi

# Source NVM for the rest of the script
# shellcheck source=/dev/null
source "$NVM_DIR/nvm.sh"

if ! command -v node >/dev/null; then
  log "Installing Node.js LTS"
  nvm install --lts
  nvm alias default lts/*
else
  skip "Node.js already installed ($(node --version))"
fi

# ------------------------------------------------------------------------------
# Java (OpenJDK 25 LTS) + Maven
# ------------------------------------------------------------------------------
if ! command -v javac >/dev/null; then
  log "Installing OpenJDK 25 + Maven"
  sudo dnf install -y java-25-openjdk java-25-openjdk-devel maven
  JAVA_HOME_PATH=$(dirname "$(dirname "$(readlink -f "$(which javac)")")")
  echo "export JAVA_HOME=$JAVA_HOME_PATH" >>"$HOME/.zshrc"
else
  skip "Java already installed"
fi

# ------------------------------------------------------------------------------
# Lua + LuaRocks
# ------------------------------------------------------------------------------
if ! command -v lua >/dev/null; then
  log "Installing Lua + LuaRocks"
  sudo dnf install -y lua luarocks
else
  skip "Lua already installed"
fi

# ------------------------------------------------------------------------------
# LazyGit
# ------------------------------------------------------------------------------
if ! command -v lazygit >/dev/null; then
  log "Installing LazyGit (via COPR)"
  sudo dnf copr enable atim/lazygit -y
  sudo dnf install -y lazygit
else
  skip "LazyGit already installed"
fi

# ------------------------------------------------------------------------------
# Git configuration
# ------------------------------------------------------------------------------
log "Configuring Git"
git config --global user.name "towh2301"
git config --global user.email "huy.buihoang2301@gmail.com"
git config --global core.editor nvim
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global core.autocrlf input


# ------------------------------------------------------------------------------
# Docker + Lazydocker + Kubernetes + PDF Viewer
# ------------------------------------------------------------------------------

# Docker Engine
if ! command -v docker >/dev/null; then
  log "Installing Docker Engine"

  # Remove old versions
  sudo dnf remove -y docker \
    docker-client \
    docker-client-latest \
    docker-common \
    docker-latest \
    docker-latest-logrotate \
    docker-logrotate \
    docker-selinux \
    docker-engine-selinux \
    docker-engine 2>/dev/null || true

  # Add Docker repository
  sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo

  # Install Docker packages
  sudo dnf install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

  # Start and enable Docker service
  sudo systemctl start docker
  sudo systemctl enable docker

  # Add current user to docker group
  sudo usermod -aG docker "$USER"

  echo "⚠️  Docker group added - log out and back in for changes to take effect"
else
  skip "Docker already installed ($(docker --version 2>/dev/null || echo 'version check failed'))"
fi

# Docker Compose standalone symlink
if ! command -v docker-compose >/dev/null 2>&1; then
  if [ -f /usr/libexec/docker/cli-plugins/docker-compose ]; then
    log "Creating docker-compose symlink"
    sudo ln -sf /usr/libexec/docker/cli-plugins/docker-compose /usr/local/bin/docker-compose
  fi
else
  skip "docker-compose already available"
fi

# Docker daemon optimization
DOCKER_DAEMON_JSON="/etc/docker/daemon.json"
if [ ! -f "$DOCKER_DAEMON_JSON" ]; then
  log "Configuring Docker daemon for performance"
  sudo mkdir -p /etc/docker
  sudo tee "$DOCKER_DAEMON_JSON" >/dev/null <<'DOCKEREOF'
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  },
  "storage-driver": "overlay2",
  "features": {
    "buildkit": true
  },
  "default-address-pools": [
    {
      "base": "172.17.0.0/12",
      "size": 24
    }
  ]
}
DOCKEREOF
  if systemctl is-active --quiet docker; then
    sudo systemctl restart docker
  fi
else
  skip "Docker daemon.json already configured"
fi

# Lazydocker
if ! command -v lazydocker >/dev/null; then
  log "Installing Lazydocker"
  LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  if [ -n "$LAZYDOCKER_VERSION" ]; then
    curl -fsSL "https://github.com/jesseduffield/lazydocker/releases/download/v${LAZYDOCKER_VERSION}/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz" |
      sudo tar -xz -C /usr/local/bin lazydocker
    sudo chmod +x /usr/local/bin/lazydocker
  else
    echo "⚠️  Could not determine Lazydocker version"
  fi
else
  skip "Lazydocker already installed"
fi

# kubectl
if ! command -v kubectl >/dev/null; then
  log "Installing kubectl"
  KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
  curl -fsSLO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
  curl -fsSLO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl.sha256"

  # Verify checksum
  if echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check --status; then
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    rm kubectl kubectl.sha256

    # Add completion
    if ! grep -q "kubectl completion zsh" "$HOME/.zshrc" 2>/dev/null; then
      echo 'source <(kubectl completion zsh)' >>"$HOME/.zshrc"
    fi
  else
    echo "⚠️  kubectl checksum verification failed"
    rm kubectl kubectl.sha256
  fi
else
  skip "kubectl already installed"
fi

# Minikube
if ! command -v minikube >/dev/null; then
  log "Installing Minikube"
  curl -fsSLO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo install minikube-linux-amd64 /usr/local/bin/minikube
  rm minikube-linux-amd64

  # Add completion
  if ! grep -q "minikube completion zsh" "$HOME/.zshrc" 2>/dev/null; then
    echo 'source <(minikube completion zsh)' >>"$HOME/.zshrc"
  fi
else
  skip "Minikube already installed"
fi

# Helm
if ! command -v helm >/dev/null; then
  log "Installing Helm"
  curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

  # Add completion
  if ! grep -q "helm completion zsh" "$HOME/.zshrc" 2>/dev/null; then
    echo 'source <(helm completion zsh)' >>"$HOME/.zshrc"
  fi
else
  skip "Helm already installed"
fi

# k9s (Kubernetes TUI)
if ! command -v k9s >/dev/null; then
  log "Installing k9s"
  K9S_VERSION=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | grep -Po '"tag_name": "v\K[^"]*')
  if [ -n "$K9S_VERSION" ]; then
    curl -fsSL "https://github.com/derailed/k9s/releases/download/v${K9S_VERSION}/k9s_Linux_amd64.tar.gz" |
      sudo tar -xz -C /usr/local/bin k9s
    sudo chmod +x /usr/local/bin/k9s
  else
    echo "⚠️  Could not determine k9s version"
  fi
else
  skip "k9s already installed"
fi

# kubectx + kubens
if ! command -v kubectx >/dev/null; then
  log "Installing kubectx + kubens"
  if [ ! -d /opt/kubectx ]; then
    sudo git clone --depth=1 https://github.com/ahmetb/kubectx /opt/kubectx
  fi
  sudo ln -sf /opt/kubectx/kubectx /usr/local/bin/kubectx
  sudo ln -sf /opt/kubectx/kubens /usr/local/bin/kubens

  # Add completions
  mkdir -p "$ZSH_CUSTOM/completions"
  ln -sf /opt/kubectx/completion/_kubectx.zsh "$ZSH_CUSTOM/completions/_kubectx" 2>/dev/null || true
  ln -sf /opt/kubectx/completion/_kubens.zsh "$ZSH_CUSTOM/completions/_kubens" 2>/dev/null || true
else
  skip "kubectx/kubens already installed"
fi

# k3d (lightweight k8s in docker - alternative to minikube)
if ! command -v k3d >/dev/null; then
  log "Installing k3d"
  curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

  # Add completion
  if ! grep -q "k3d completion zsh" "$HOME/.zshrc" 2>/dev/null; then
    echo 'source <(k3d completion zsh)' >>"$HOME/.zshrc"
  fi
else
  skip "k3d already installed"
fi

# Docker Credential Helper (for private registries)
if ! command -v docker-credential-secretservice >/dev/null; then
  log "Installing docker-credential-helper"
  sudo dnf install -y docker-credential-secretservice 2>/dev/null ||
    echo "⚠️  docker-credential-secretservice not available in repos"
else
  skip "docker-credential-helper already installed"
fi

# ------------------------------------------------------------------------------
# PDF Viewers
# ------------------------------------------------------------------------------
log "Installing PDF viewers"

PDF_VIEWERS=(
  evince            # GNOME default - lightweight, fast
  okular            # KDE viewer - feature-rich with annotations
  zathura           # Minimal, vim-like keybindings
  zathura-pdf-mupdf # PDF backend for zathura
)

TO_INSTALL=()
for pkg in "${PDF_VIEWERS[@]}"; do
  if ! rpm -q "$pkg" >/dev/null 2>&1; then
    TO_INSTALL+=("$pkg")
  fi
done

if [ ${#TO_INSTALL[@]} -gt 0 ]; then
  sudo dnf install -y "${TO_INSTALL[@]}"
else
  skip "PDF viewers already installed"
fi

# Set default PDF viewer (optional - using xdg-mime)
if command -v evince >/dev/null; then
  log "Setting Evince as default PDF viewer"
  xdg-mime default org.gnome.Evince.desktop application/pdf 2>/dev/null || true
fi

log "Container, Kubernetes, and PDF tools installation complete!"

# ------------------------------------------------------------------------------
# System optimizations
# ------------------------------------------------------------------------------
log "Applying system optimizations"

# zram (Fedora defaults to zram-generator)
if [ ! -f /etc/systemd/zram-generator.conf ]; then
  log "Tuning zram (half RAM, zstd)"
  sudo tee /etc/systemd/zram-generator.conf >/dev/null <<'EOF'
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
EOF
  sudo systemctl daemon-reload
  sudo systemctl restart systemd-zram-setup@zram0.service
else
  skip "zram already configured"
fi

# swappiness
if [ ! -f /etc/sysctl.d/99-swappiness.conf ]; then
  echo "vm.swappiness=10" | sudo tee /etc/sysctl.d/99-swappiness.conf >/dev/null
fi

# inotify watches
if [ ! -f /etc/sysctl.d/99-inotify.conf ]; then
  echo "fs.inotify.max_user_watches=524288" | sudo tee /etc/sysctl.d/99-inotify.conf >/dev/null
fi

sudo sysctl --system

# ------------------------------------------------------------------------------
# Cleanup
# ------------------------------------------------------------------------------
log "Cleaning up"
sudo dnf autoremove -y
sudo dnf clean all

# ------------------------------------------------------------------------------
# Summary
# ------------------------------------------------------------------------------
log "Installation complete!"
echo ""
echo "📋 Installed/Verified:"
echo " ✓ C/C++: GCC/Clang, CMake, GDB, Valgrind, Boost, GoogleTest, etc."
echo " ✓ C++ Managers: vcpkg, Conan"
echo " ✓ Zsh + plugins"
echo " ✓ Neovim + custom LazyVim config"
echo " ✓ Node.js ($(node --version 2>/dev/null || echo 'N/A'))"
echo " ✓ Java 25 LTS + Maven"
echo " ✓ Lua + LuaRocks"
echo " ✓ LazyGit"
echo " ✓ System optimizations (zram, swappiness, inotify)"
echo " ✓ Installed Docker, Lazydocker, k9s"
echo " ✓ Installed PDF viewers"
echo ""
echo "⚠️ IMPORTANT:"
echo " • Run 'source ~/.zshrc' or open a new terminal"
echo " • Run 'sudo reboot' recommended for full effect (shell, zram, etc.)"
echo ""
echo "📚 Quick tips:"
echo " • C++ build: g++ -std=c++23 -Wall -Wextra -O2 file.cpp"
echo " • Debug: gdb ./a.out"
echo " • Valgrind: valgrind --leak-check=full ./a.out"
echo " • vcpkg install <pkg>  • conan install ..."
echo ""
