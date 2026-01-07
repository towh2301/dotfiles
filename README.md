# 🛠️ dotfiles

A collection of my personal configuration files and scripts designed to streamline my development workflow. This setup focuses on efficiency, featuring optimized configurations for **Zsh, Vim, Bash,** and more.

Using `GNU Stow`, these dotfiles can be easily synchronized and deployed across different machines.

## 🚀 Quick Start

### Prerequisites

Ensure you have the following tools installed on your system:

* **Git** (for version control)
* **GNU Stow** (for symlink management)
* **Zsh** (primary shell)
* **FZF** (command-line fuzzy finder)

### Installation

1. **Clone the repository** to your home directory:
```bash
git clone https://github.com/towh2301/dotfiles.git ~/dotfiles
```

2. **Navigate** to the directory:
```bash
cd ~/dotfiles
```


3. **Deploy** the configurations using Stow:
```bash
stow .
```



---

## ⚙️ Customization

This setup is modular. If you use specific productivity tools, you can enable them by editing the `.zshrc` file:

* **zoxide:** Find the `zoxide` line in `.zshrc` and uncomment it to enable smarter directory navigation.
* **tmuxifier:** Find the `tmuxifier` line in `.zshrc` and uncomment it to enable tmux session management.

## 📂 Repository Structure

* `zsh/` – Zsh shell configurations and themes.
* `vim/` – Vim editor settings and plugin management.
* `bash/` – Fallback Bash configurations.
* `scripts/` – Custom utility scripts for daily tasks.

## 🤝 Contributing

I’m always looking to improve my workflow! If you have suggestions or find a bug:

1. Open an **Issue** to discuss changes.
2. Submit a **Pull Request** with your improvements.

## 📄 License

This project is licensed under the **MIT License**. See the [LICENSE](https://www.google.com/search?q=LICENSE) file for details.

© 2026 **towh2301**
