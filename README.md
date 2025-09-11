# NixOS System Configurations

[![NixOS](https://img.shields.io/badge/NixOS-5277C3?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.org)
[![Hyprland](https://img.shields.io/badge/Hyprland-58A6FF?style=for-the-badge&logo=hyprland&logoColor=white)](https://hyprland.org)
[![Flakes](https://img.shields.io/badge/Flakes-Enabled-5277C3?style=for-the-badge)](https://nixos.wiki/wiki/Flakes)

This repository contains my personal NixOS system configurations, managed with Nix Flakes. It features a complete desktop environment with Hyprland compositor, beautiful Gruvbox theming, and extensive development tooling.

<img width="1034" height="1280" alt="Desktop Screenshot" src="https://github.com/user-attachments/assets/e819499b-5dde-4ca7-a4dc-75b3e790e5d3" />

---

## System Information

- **OS**: NixOS 25.05 (Unstable)
- **Kernel**: Linux 6.12
- **Window Manager**: Hyprland
- **Shell**: Zsh with Oh My Zsh
- **Terminal**: Alacritty
- **Editor**: VSCode + Neovim
- **Theme**: Gruvbox Dark Soft
- **Font**: JetBrains Mono

---

## Quick Start

### Installation
```bash
# Clone the repository
git clone git@github.com:vwh/nixos-config.git ~/System
cd ~/System

# Apply the configuration
just all  # or follow the step-by-step process below
```

### Onboarding a New Machine

1. **Clone the repo:**
   ```bash
   git clone git@github.com:vwh/nixos-config.git ~/System
   cd ~/System
   ```

2. **Create the host configuration:**
   ```bash
   cd hosts
   cp -r pc <new-hostname>
   ```

3. **Copy the hardware configuration:**
   ```bash
   cp /etc/nixos/hardware-configuration.nix hosts/<new-hostname>/
   ```

4. **Add the new host to `flake.nix`:**
   Open `flake.nix` and add your new host to the `hosts` list.

5. **Deploy the system:**
   ```bash
   # For the new host
   sudo nixos-rebuild switch --flake ~/System#<new-hostname>

   # For home-manager
   home-manager switch --flake ~/System#yazan
   ```

---

## Services

The system runs several services that are accessible via web interfaces or network ports:

### Web Services
| Service | URL | Description |
|---------|-----|-------------|
| **Glance Dashboard** | `http://localhost:8080` | System overview dashboard with widgets |
| **CUPS Print Server** | `http://localhost:631` | Printer configuration and management |
| **Qdrant Web UI** | `http://localhost:6333` | Vector search engine interface for AI code indexing |

### System Services
| Service | Status | Description |
|---------|--------|-------------|
| **Hyprland** | ✔ Enabled | Wayland window manager |
| **PipeWire** | ✔ Enabled | Audio server with PulseAudio compatibility |
| **NetworkManager** | ✔ Enabled | Network management |
| **Bluetooth** | ✔ Enabled | Wireless device support |
| **Tor** | ✔ Enabled | Anonymous networking |
| **Printing** | ✔ Enabled | CUPS print services |
| **Docker** | ✔ Enabled | Container runtime |
| **VirtualBox** | ✔ Enabled | Virtualization platform |
| **SOPS** | ✔ Enabled | Secret management |
| **Ollama** | ✔ Enabled | Local AI models and embeddings service (port 11434) |
| **Qdrant** | ✔ Enabled | Vector search engine for AI-powered code indexing (port 6333) |

### Monitoring & System
| Service | Purpose |
|---------|---------|
| **System Monitoring** | Hardware sensors, system resources |
| **Network Monitoring** | Connection monitoring and diagnostics |
| **Power Management** | Battery and power optimization |

---

## Secrets Management

This configuration uses `sops-nix` for managing encrypted secrets with age keys.

### Quick Start

1. **Setup age key** (if not already done):
   ```bash
   just sops-setup
   ```

2. **View current secrets**:
   ```bash
   just sops-view
   ```

3. **Edit secrets**:
   ```bash
   just sops-edit
   ```

4. **Add single secret**:
   ```bash
   just secrets-add github_token ghp_your_token_here
   ```

### Available Commands

| Command | Purpose |
|---------|---------|
| `just sops-view` | View decrypted secrets |
| `just sops-edit` | Edit secrets (opens editor) |
| `just secrets-add key value` | Add single secret |
| `just sops-decrypt` | Decrypt to file for manual editing |
| `just sops-encrypt` | Encrypt file back to secrets |
| `just sops-key` | Show public key |
| `just sops-setup` | Setup age key |

### Security Notes

- Secrets are encrypted at rest using age encryption
- Private keys are stored in `~/.config/sops/age/keys.txt`
- Never commit private keys or decrypted secrets to Git
- Use `just sops-edit` for most editing (automatic encrypt/decrypt)

---

## Deployment

### Daily Workflow

This repository uses [`just`](https://github.com/casey/just) as a command runner to simplify common tasks.

### Essential Commands
| Command | Description |
|---------|-------------|
| `just` | List all available commands |
| `just all` | Run the full pipeline: check, lint, format, and deploy |
| `just nixos` | Rebuild and switch NixOS configuration |
| `just home` | Apply Home-Manager configuration |
| `just format` | Format all `.nix` files with `nixfmt` |
| `just lint` | Lint all `.nix` files with `statix` |
| `just modules` | Check for missing module imports |
| `just update` | Update all flake inputs |
| `just clean` | Clean up build artifacts and caches |

---

## Project Structure

```
.
├── devShells/                     ← Project development environments
│   ├── bun/                       ← Bun runtime environment
│   ├── deno/                      ← Deno runtime environment
│   ├── go/                        ← Go development environment
│   ├── nodejs/                    ← Node.js environment
│   ├── python-venv/               ← Python virtual environment
│   ├── rust-nightly/              ← Rust nightly toolchain
│   ├── rust-stable/               ← Rust stable toolchain
│   ├── .envrc
│   ├── flake.lock
│   ├── flake.nix
│   ├── .gitignore
│   └── README.md
├── home-manager/                  ← Home-Manager configuration
│   ├── modules/                   ← Reusable home-manager modules
│   │   ├── apps/                  ← Application-specific configs
│   │   │   ├── warp/
│   │   │   │   └── default.nix
│   │   │   ├── default.nix
│   │   │   ├── glance.nix
│   │   │   ├── obs.nix
│   │   │   ├── spicetify.nix
│   │   │   └── zen.nix
│   │   ├── hyprland/              ← Window manager configuration
│   │   │   ├── swaync/
│   │   │   │   └── default.nix
│   │   │   ├── waybar/
│   │   │   │   ├── default.nix
│   │   │   │   └── style.css
│   │   │   ├── wofi/
│   │   │   │   ├── default.nix
│   │   │   │   └── style.css
│   │   │   ├── binds.nix
│   │   │   ├── default.nix
│   │   │   ├── hypridle.nix
│   │   │   ├── hyprlock.nix
│   │   │   ├── hyprpaper.nix
│   │   │   └── main.nix
│   │   ├── languages/             ← Programming language setups
│   │   │   ├── default.nix
│   │   │   ├── go.nix
│   │   │   ├── javascript.nix
│   │   │   └── python.nix
│   │   ├── terminal/              ← Terminal and shell configs
│   │   │   ├── tools/
│   │   │   │   ├── bat.nix
│   │   │   │   ├── cava.nix
│   │   │   │   ├── default.nix
│   │   │   │   ├── eza.nix
│   │   │   │   ├── git.nix
│   │   │   │   ├── htop.nix
│   │   │   │   ├── lazygit.nix
│   │   │   │   ├── zathura.nix
│   │   │   │   └── zoxide.nix
│   │   │   ├── zsh/
│   │   │   │   ├── custom_omz_dir/
│   │   │   │   │   └── themes/
│   │   │   │   │       └── oxide.zsh-theme
│   │   │   │   ├── aliases.nix
│   │   │   │   └── default.nix
│   │   │   ├── alacritty.nix
│   │   │   ├── default.nix
│   │   │   ├── tmux.nix
│   │   │   └── yazi.nix
│   │   ├── default.nix
│   │   ├── gpg.nix
│   │   ├── mime.nix
│   │   ├── overlays.nix
│   │   ├── qt.nix
│   │   └── stylix.nix
│   ├── packages/                  ← Grouped package lists
│   │   ├── custom/
│   │   │   ├── prayer.nix
│   │   │   └── warp.nix
│   │   ├── applications.nix
│   │   ├── cli.nix
│   │   ├── cool.nix
│   │   ├── default.nix
│   │   ├── development.nix
│   │   ├── gnome.nix
│   │   ├── hyprland.nix
│   │   ├── multimedia.nix
│   │   ├── networking.nix
│   │   ├── system-monitoring.nix
│   │   └── utilities.nix
│   └── home.nix                   ← Main home configuration
├── hosts/                         ← Per-host NixOS configurations
│   ├── pc/                        ← Desktop workstation config
│   │   ├── modules/
│   │   │   ├── default.nix
│   │   │   └── power.nix
│   │   ├── configuration.nix
│   │   ├── hardware-configuration.nix
│   │   └── local-packages.nix
│   └── thinkpad/                  ← Laptop configuration
│       ├── modules/
│       │   ├── boot.nix
│       │   ├── default.nix
│       │   ├── nvidia.nix
│       │   ├── power.nix
│       │   └── tlp.nix
│       ├── configuration.nix
│       ├── hardware-configuration.nix
│       └── local-packages.nix
├── nixos/                         ← Shared NixOS modules
│   └── modules/                   ← System-level configurations
│       ├── audio.nix              ← Audio system (PipeWire)
│       ├── bluetooth.nix          ← Bluetooth support
│       ├── bootloader.nix         ← Boot loader configuration
│       ├── cleanup.nix            ← System cleanup tasks
│       ├── default.nix            ← Module imports
│       ├── environment.nix        ← Environment variables
│       ├── gaming.nix             ← Gaming optimizations
│       ├── gnome.nix              ← GNOME desktop (optional)
│       ├── graphics.nix           ← Graphics drivers
│       ├── hyprland.nix           ← Window manager setup
│       ├── i18n.nix               ← Internationalization
│       ├── libinput.nix           ← Input device support
│       ├── monitoring.nix         ← System monitoring
│       ├── nautilus.nix           ← File manager configuration
│       ├── networking.nix         ← Network configuration
│       ├── nix-ld.nix             ← Dynamic linker
│       ├── nix.nix                ← Nix package manager config
│       ├── printing.nix           ← Print services
│       ├── sops.nix               ← Secret management
│       ├── stability.nix          ← System stability
│       ├── timezone.nix           ← Time zone configuration
│       ├── tor.nix                ← Tor network
│       ├── upower.nix             ← Power management
│       ├── users.nix              ← User account management
│       ├── virtualisation.nix     ← Docker/VirtualBox
│       └── xserver.nix            ← X11 server configuration
├── scripts/                       ← Utility scripts
│   ├── build/
│   │   └── modules-check.sh
│   └── waybar/
│       ├── gpu-temp.sh
│       └── network.sh
├── secrets/                       ← Encrypted secrets (sops-nix)
│   └── secrets.yaml
├── themes/                        ← Custom themes and wallpapers
│   └── gruvbox.tdesktop-theme
├── .envrc                         ← Environment configuration
├── flake.nix                      ← Main Nix flake configuration
├── flake.lock                     ← Locked dependency versions
├── justfile                       ← Task runner commands
├── LICENSE                        ← License information
├── README.md                      ← This file
└── .sops.yaml                     ← SOPS configuration
```

### Key Directories Explained

- **`home-manager/`** - User-space configuration managed by Home-Manager
- **`hosts/`** - Machine-specific system configurations
- **`devShells/`** - Isolated development environments for different languages
- **`nixos/modules/`** - Reusable system-level modules
- **`secrets/`** - Encrypted configuration files using sops-nix
- **`themes/`** - Custom application themes matching the Gruvbox aesthetic
- **`scripts/`** - Utility scripts for automation and setup

---


### Getting Help

- **NixOS Documentation**: https://nixos.org/manual/
- **Home Manager Manual**: https://nix-community.github.io/home-manager/
- **Hyprland Wiki**: https://hyprland.org/
- **Nix Flakes**: https://nixos.wiki/wiki/Flakes
