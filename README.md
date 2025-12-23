# NixOS System Configurations

[![NixOS](https://img.shields.io/badge/NixOS-5277C3?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.org)
[![Hyprland](https://img.shields.io/badge/Hyprland-58A6FF?style=for-the-badge&logo=hyprland&logoColor=white)](https://hyprland.org)
[![Flakes](https://img.shields.io/badge/Flakes-Enabled-5277C3?style=for-the-badge)](https://nixos.wiki/wiki/Flakes)

This repository contains my personal NixOS system configurations, managed with Nix Flakes. It features a complete desktop environment with Hyprland compositor, beautiful Gruvbox theming, extensive development tooling, and AI-powered development utilities.

<img width="1034" height="1280" alt="Desktop Screenshot" src="https://github.com/user-attachments/assets/e819499b-5dde-4ca7-a4dc-75b3e790e5d3" />

---

## Quick Start

### Installation
```bash
# Clone the repository
git clone git@github.com:vwh/nixos-config.git ~/System
cd ~/System

# Apply the configuration (runs full pipeline: modules check, lint, format, nh os switch, home-manager switch)
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
   # For the new host (using modern nh)
   nh os switch --flake ~/System#<new-hostname>

   # For home-manager (using nh)
   nh home switch --flake ~/System#yazan

   # Or use the just commands:
   just nixos  # System rebuild
   just home   # Home Manager only
   ```

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

## Flake Inputs

This configuration uses the following flakes:

- **nixpkgs** - NixOS unstable packages
- **nixpkgs-stable** - NixOS 25.11 stable packages
- **home-manager** - User environment management
- **stylix** - System theming and styling (Gruvbox theme)
- **spicetify-nix** - Spotify customization
- **sops-nix** - Secret management with age encryption
- **zen-browser** - Privacy-focused web browser
- **hexecute** - Gesture-based application launcher

---

## Deployment

### Daily Workflow

This repository uses [`just`](https://github.com/casey/just) as a command runner to simplify common tasks.

### Essential Commands

| Command | Description |
|---------|-------------|
| `just` | List all available commands |
| `just all` | **Run full pipeline**: modules check, lint, format, nh os switch, home-manager switch |
| `just nixos` | Rebuild and switch NixOS configuration using **nh** (modern Nix Helper) |
| `just home` | Apply Home-Manager configuration using **nh** (safe, user-level only) |
| `just format` | Format all `.nix` files with `nixfmt` |
| `just lint` | Lint all `.nix` files with `statix` + bash shellcheck |
| `just modules` | Check for missing module imports (**critical before commits**) |
| `just update` | Update all flake inputs |
| `just clean` | Clean up old generations and optimize store using **nh** |

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
│       ├── browser-deps.nix       ← Browser environment configuration
│       ├── cleanup.nix            ← System cleanup tasks
│       ├── default.nix            ← Module imports
│       ├── environment.nix        ← Environment variables
│       ├── gaming.nix             ← Gaming (Steam, Lutris, Wine, MangoHud)
│       ├── gnome.nix              ← GNOME desktop (optional)
│       ├── graphics.nix           ← Graphics drivers
│       ├── hyprland.nix           ← Window manager setup
│       ├── i18n.nix               ← Internationalization
│       ├── libinput.nix           ← Input device support
│       ├── monitoring.nix         ← System monitoring
│       ├── mullvad-vpn.nix        ← Mullvad VPN configuration
│       ├── nautilus.nix           ← File manager configuration
│       ├── networking.nix         ← Network configuration
│       ├── nh.nix                 ← Nix Helper (nh) configuration
│       ├── nix-ld.nix             ← Dynamic linker for non-Nix binaries
│       ├── nix.nix                ← Nix package manager config
│       ├── ollama.nix             ← Local AI models service
│       ├── printing.nix           ← Print services
│       ├── qdrant.nix             ← Vector search engine
│       ├── scripts.nix            ← Custom utility scripts
│       ├── security.nix           ← **System security hardening**
│       ├── sops.nix               ← Secret management
│       ├── stability.nix          ← System stability
│       ├── timezone.nix           ← Time zone configuration
│       ├── tor.nix                ← Tor network
│       ├── upower.nix             ← Power management
│       ├── users.nix              ← User account management
│       ├── virtualisation.nix     ← Docker/libvirt
│       ├── xdg-desktop-portal.nix ← XDG desktop portal configuration
│       └── xserver.nix            ← X11 server configuration
├── scripts/                       ← Utility scripts
│   ├── ai/                       ← **AI-powered development tools**
│   │   ├── ask.sh                ← General-purpose AI assistant (GLM-4.6)
│   │   ├── commit.sh             ← Intelligent commit generation
│   │   └── help.sh               ← Command-line assistant
│   ├── build/
│   │   └── modules-check.sh      ← Module import validation
│   ├── generate-file-context.sh  ← **AI file context generator**
│   ├── sops/
│   │   ├── sops-setup.sh         ← SOPS age key initialization
│   │   └── setup-keys.sh         ← SSH/GPG keys from SOPS
│   └── waybar/
│       ├── gpu-temp.sh           ← GPU temperature widget
│       └── network.sh            ← Network monitoring widget
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
