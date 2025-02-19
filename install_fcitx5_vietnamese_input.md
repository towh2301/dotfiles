## Hướng dẫn cài đặt `fcitx5` và `fcitx5-bamboo`

### 1. Cài đặt `fcitx5` và các phụ thuộc

Cài đặt `fcitx5` và các gói cần thiết:

```bash
sudo dnf install fcitx5 fcitx5-qt fcitx5-gtk fcitx5-configtool
```

### 2. Cài đặt `fcitx5-bamboo` từ mã nguồn

Clone repository `fcitx5-bamboo` và `bamboo-core`, sau đó biên dịch và cài đặt:

```bash
# Clone repositories
git clone https://github.com/fcitx/fcitx5-bamboo.git
git clone https://github.com/BambooEngine/bamboo-core.git

# Di chuyển bamboo-core vào đúng vị trí
mv bamboo-core fcitx5-bamboo/bamboo/bamboo-core

# Biên dịch và cài đặt
cd fcitx5-bamboo
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
make
sudo make install
```

### 3. Cấu hình `fcitx5`

Thêm `fcitx5` vào autostart và thiết lập biến môi trường:

```bash
# Thêm vào autostart (ví dụ: ~/.config/sway/config hoặc ~/.bashrc)
echo 'exec fcitx5 -d' >> ~/.config/sway/config

# Thiết lập biến môi trường
echo 'export GTK_IM_MODULE=fcitx5' >> ~/.bashrc
echo 'export QT_IM_MODULE=fcitx5' >> ~/.bashrc
echo 'export XMODIFIERS=@im=fcitx5' >> ~/.bashrc

# Reload shell
source ~/.bashrc
```

### 4. Cấu hình bộ gõ `Bamboo`

Chạy `fcitx5-configtool` để thêm bộ gõ `Bamboo`:

```bash
fcitx5-configtool
```

- Trong cửa sổ cấu hình, nhấp vào nút **"Add"** (Thêm).
- Tìm và chọn **"Bamboo"** từ danh sách các bộ gõ.
- Nhấp **"OK"** để lưu cấu hình.

---

## Shell Script tự động hóa cài đặt

Dưới đây là một shell script để tự động hóa toàn bộ quá trình cài đặt:

```bash
#!/bin/bash

# Cài đặt fcitx5 và các phụ thuộc
echo "Installing fcitx5 and dependencies..."
sudo dnf install -y fcitx5 fcitx5-qt fcitx5-gtk fcitx5-configtool cmake extra-cmake-modules golang

# Clone repositories
echo "Cloning fcitx5-bamboo and bamboo-core..."
git clone https://github.com/fcitx/fcitx5-bamboo.git
git clone https://github.com/BambooEngine/bamboo-core.git

# Di chuyển bamboo-core vào đúng vị trí
echo "Moving bamboo-core to the correct location..."
mv bamboo-core fcitx5-bamboo/bamboo/bamboo-core

# Biên dịch và cài đặt fcitx5-bamboo
echo "Building and installing fcitx5-bamboo..."
cd fcitx5-bamboo
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
make
sudo make install

# Cấu hình fcitx5 autostart và biến môi trường
echo "Configuring fcitx5 autostart and environment variables..."
echo 'exec fcitx5 -d' >> ~/.config/sway/config
echo 'export GTK_IM_MODULE=fcitx5' >> ~/.bashrc
echo 'export QT_IM_MODULE=fcitx5' >> ~/.bashrc
echo 'export XMODIFIERS=@im=fcitx5' >> ~/.bashrc

# Reload shell
source ~/.bashrc

echo "Installation complete! Please restart your session or run 'fcitx5-configtool' to add the Bamboo input method."
```

---

### Cách sử dụng shell script

1. Lưu script vào một file, ví dụ: `install_fcitx5.sh`.
2. Cấp quyền thực thi cho script:
   ```bash
   chmod +x install_fcitx5.sh
   ```
3. Chạy script:
   ```bash
   ./install_fcitx5.sh
   ```

---

## File Markdown cho Dotfiles

Bạn có thể thêm hướng dẫn này vào file `README.md` hoặc một file markdown khác trong dotfiles của mình như sau:

````markdown
# Fcitx5 và Fcitx5-Bamboo Setup

## Cài đặt

### 1. Cài đặt `fcitx5` và các phụ thuộc

```bash
sudo dnf install fcitx5 fcitx5-qt fcitx5-gtk fcitx5-configtool
```
````

### 2. Cài đặt `fcitx5-bamboo` từ mã nguồn

```bash
git clone https://github.com/fcitx/fcitx5-bamboo.git
git clone https://github.com/BambooEngine/bamboo-core.git
mv bamboo-core fcitx5-bamboo/bamboo/bamboo-core
cd fcitx5-bamboo
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
make
sudo make install
```

### 3. Cấu hình `fcitx5`

Thêm vào autostart và thiết lập biến môi trường:

```bash
echo 'exec fcitx5 -d' >> ~/.config/sway/config
echo 'export GTK_IM_MODULE=fcitx5' >> ~/.bashrc
echo 'export QT_IM_MODULE=fcitx5' >> ~/.bashrc
echo 'export XMODIFIERS=@im=fcitx5' >> ~/.bashrc
source ~/.bashrc
```

### 4. Cấu hình bộ gõ `Bamboo`

Chạy `fcitx5-configtool` để thêm bộ gõ `Bamboo`.

## Shell Script tự động hóa

Lưu script sau vào `install_fcitx5.sh` và chạy:

```bash
#!/bin/bash
# Script tự động cài đặt fcitx5 và fcitx5-bamboo
# (Nội dung script như trên)
```
