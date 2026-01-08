# NixOS System Configurations

This repository contains my personal NixOS system configurations, managed with Nix Flakes. It features a complete desktop environment with Hyprland compositor, beautiful Gruvbox theming, extensive development tooling, and AI-powered development utilities.

---

## Quick Start

### Installation
```bash
# Clone repository
git clone git@github.com:vwh/nixos-config.git ~/System
cd ~/System

# Apply configuration (runs full pipeline: modules check, lint, dead code check, format, flake check, nh os switch, home-manager switch)
just all
```

### Onboarding a New Machine

#### 1. Clone repo:
```bash
git clone git@github.com:vwh/nixos-config.git ~/System
cd ~/System
```

#### 2. Create host configuration:
```bash
cd hosts
cp -r pc <new-hostname>
```

#### 3. Copy hardware configuration:
```bash
cp /etc/nixos/hardware-configuration.nix hosts/<new-hostname>/
```

#### 4. Add new host to `flake.nix`:
Open `flake.nix` and add your new host to the `hosts` list with appropriate configuration.

#### 5. Deploy system:
```bash
# For new host (using modern nh)
nh os switch --flake ~/System#<new-hostname>
nh home switch --flake ~/System#yazan

# Or use just commands:
just nixos
just home
```

---

## Secrets Management

This configuration uses `sops-nix` for managing encrypted secrets with age keys.

### Quick Start
```bash
# Setup age key (if not already done)
just sops-setup

# View current secrets
just sops-view

# Edit secrets (opens editor with auto encrypt/decrypt)
just sops-edit

# Add single secret
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

## Available Commands

| Command | Purpose |
|---------|---------|
| `just` | List all available commands |
| `just all` | **Run full pipeline**: modules, lint, dead code, format, flake check, nixos, home |
| `just nixos` | Rebuild and switch NixOS configuration using **nh** (modern Nix helper) |
| `just home` | Apply Home Manager configuration using **nh** (safe, user-level only) |
| `just format` | Format all `.nix` files with `nixfmt-tree` (fast directory-wide formatting) |
| `just lint` | Lint all `.nix` files with `statix` + bash shellcheck |
| `just dead` | Scan for unused code in `.nix` files with `deadnix` |
| `just check` | Run `nix flake check --no-build` to validate flake schema and syntax |
| `just modules` | Check for missing module imports (**critical before commits**) |
| `just update` | Update all flake inputs |
| `just clean` | Clean old generations and optimize Nix store using **nh** |
| `just sops-*` | Secret management commands (view, edit, add, decrypt, encrypt, key, setup) |

---

## System Configuration Options

This configuration uses a custom `mySystem` namespace pattern for organizing optional system-level features.

### Available Options

| Option | Description |
|---------|-------------|
| `mySystem.gaming.enable` | Enable gaming support (Steam, Lutris, Wine, MangoHud) |
| `mySystem.gaming.enableGamescope` | Enable Gamescope compositor session for Steam |
| `mySystem.sandboxing.enable` | Enable application sandboxing (Firejail, bubblewrap) |
| `mySystem.sandboxing.enableUserNamespaces` | Enable user namespaces for sandboxing |
| `mySystem.sandboxing.enableWrappedBinaries` | Enable automatic Firejail wrapping for common apps |
| `mySystem.flatpak.enable` | Enable Flatpak support with Flathub |
| `mySystem.bluetooth.enable` | Enable Bluetooth services and device management |
| `mySystem.bluetooth.powerOnBoot` | Enable Bluetooth power on boot |
| `mySystem.mullvadVpn.enable` | Enable Mullvad VPN client integration |
| `mySystem.tor.enable` | Enable Tor network services and SOCKS proxy |
| `mySystem.dnscryptProxy.enable` | Enable DNSCrypt-Proxy for encrypted DNS |
| `mySystem.macchanger.enable` | Enable MAC address randomization for privacy |

### Example Configuration

In your host configuration file (`hosts/*/configuration.nix`):

```nix
mySystem = {
  gaming = {
    enable = true;
    enableGamescope = true;
  };
  sandboxing = {
    enable = true;
    enableUserNamespaces = true;
  };
  flatpak = {
    enable = true;
  };
  bluetooth = {
    enable = false;
    powerOnBoot = false;
  };
  mullvadVpn = {
    enable = true;
  };
  tor = {
    enable = true;
  };
  dnscryptProxy = {
    enable = true;
  };
  macchanger = {
    enable = true;
  };
};
```

---

## Development Workflow

For making changes:

```bash
# 1. Make your changes
vim nixos/modules/security.nix

# 2. Check for missing module imports
just modules

# 3. Format files
just format

# 4. Scan for dead code
just dead

# 5. Lint files
just lint

# 6. Validate flake
just check

# 7. Test changes (user-level first)
just home

# 8. Apply system changes
just nixos
```

---

## Flake Inputs

This configuration uses the following flakes:

- **nixpkgs** - NixOS unstable packages
- **nixpkgs-stable** - NixOS 24.11 stable packages
- **home-manager** - User environment management
- **stylix** - System theming and styling (Gruvbox theme)
- **spicetify-nix** - Spotify customization
- **sops-nix** - Secret management with age encryption
- **hexecute** - Gesture-based application launcher

---

## Project Structure

```
.
├── devShells/                     ← Project development environments
│   ├── bun/                       ← Bun runtime environment
│   ├── deno/                      ← Deno runtime environment
│   ├── nodejs/                    ← Node.js environment
│   ├── postgresql/                ← PostgreSQL development
│   ├── python-venv/               ← Python virtual environment
│   ├── rust-stable/              ← Rust stable toolchain
│   └── rust-nightly/             ← Rust nightly toolchain
├── home-manager/                  ← Home Manager configuration
│   ├── modules/                   ← Reusable home-manager modules
│   │   ├── apps/                  ← Application-specific configs
│   │   │   ├── glance.nix
│   │   │   ├── obs.nix
│   │   │   └── spicetify.nix
│   │   ├── browser-isolation.nix   ← Browser sandboxing and Tor routing
│   │   ├── hyprland/              ← Window manager configuration
│   │   │   ├── swaync/
│   │   │   ├── waybar/
│   │   │   ├── wofi/
│   │   │   ├── binds.nix
│   │   │   ├── idle.nix
│   │   │   ├── lock.nix
│   │   │   ├── paper.nix
│   │   │   └── main.nix
│   │   ├── languages/             ← Programming language setups
│   │   │   ├── default.nix
│   │   │   ├── go.nix
│   │   │   ├── javascript.nix
│   │   │   └── python.nix
│   │   ├── terminal/              ← Terminal and shell configs
│   │   │   ├── tools/
│   │   │   ├── zsh/
│   │   │   └── custom_omz_dir/
│   │   │   ├── themes/
│   │   │   └── aliases.nix
│   │   ├── mise.nix                ← Mise runtime manager
│   │   ├── overlays.nix             ← Nix package overlays
│   │   ├── qt.nix                  ← Qt theming
│   │   ├── shell.nix               ← Shell integrations
│   │   ├── stylix.nix              ← System theming
│   │   ├── gpg.nix                 ← GPG key management
│   │   ├── mime.nix                ← MIME type associations
│   │   └── home.nix              ← Main home configuration
│   └── packages/                  ← Grouped package lists
│       ├── applications.nix
│       ├── cli.nix
│       ├── cool.nix
│       ├── development.nix
│       ├── gnome.nix
│       ├── hyprland.nix
│       ├── multimedia.nix
│       ├── networking.nix
│       ├── privacy.nix
│       ├── system-monitoring.nix
│       └── utilities.nix
├── hosts/                         ← Per-host NixOS configurations
│   ├── pc/                        ← Desktop workstation
│   │   ├── configuration.nix       ← Main configuration
│   │   ├── hardware-configuration.nix ← Auto-generated
│   │   ├── local-packages.nix      ← Host-specific packages
│   │   └── modules/
│   │       ├── default.nix
│   │       └── power.nix
│   └── thinkpad/                 ← Laptop configuration
│       ├── configuration.nix       ← Main configuration
│       ├── hardware-configuration.nix ← Auto-generated
│       ├── local-packages.nix      ← Host-specific packages
│       └── modules/
│           ├── boot.nix
│           ├── nvidia.nix            ← NVIDIA Optimus (hybrid graphics)
│           ├── power.nix
│           ├── tlp.nix
│           └── configuration.nix
├── nixos/                        ← Shared NixOS system modules
│   ├── modules/                   ← System-level configurations
│   │   ├── audio.nix              ← Audio system (PipeWire)
│   │   ├── bluetooth.nix          ← Bluetooth support
│   │   ├── bootloader.nix         ← Boot loader configuration
│   │   ├── cleanup.nix            ← System cleanup tasks
│   │   ├── default.nix            ← Module imports
│   │   ├── dnscrypt-proxy.nix    ← DNSCrypt-Proxy for encrypted DNS
│   │   ├── environment.nix        ← Environment variables
│   │   ├── flatpak.nix            ← Flatpak support with Flathub
│   │   ├── gaming.nix             ← Gaming (Steam, Lutris, Wine, MangoHud)
│   │   ├── graphics.nix            ← Graphics drivers and CUDA
│   │   ├── hyprland.nix           ← Window manager setup
│   │   ├── i18n.nix              ← Internationalization
│   │   ├── libinput.nix           ← Input device support
│   │   ├── macchanger.nix         ← MAC address randomization
│   │   ├── monitoring.nix          ← System monitoring (Powertop, thermald)
│   │   ├── mullvad-vpn.nix        ← Mullvad VPN configuration
│   │   ├── nautilus.nix           ← File manager configuration
│   │   ├── networking.nix         ← Network configuration
│   │   ├── nh.nix                 ← Nix Helper (nh) configuration
│   │   ├── nix-ld.nix             ← Dynamic linker for non-Nix binaries
│   │   ├── nix.nix                ← Nix package manager config
│   │   ├── printing.nix            ← Print services
│   │   ├── sandboxing.nix          ← Application sandboxing (Firejail, bubblewrap)
│   │   ├── security.nix            ← System security hardening
│   │   ├── sops.nix               ← Secret management
│   │   ├── stability.nix           ← System stability settings
│   │   ├── timezone.nix           ← Time zone configuration
│   │   ├── tor.nix                 ← Tor network services
│   │   ├── upower.nix             ← Power management
│   │   ├── users.nix              ← User account management
│   │   ├── virtualisation.nix      ← Docker and libvirt
│   │   ├── xdg-desktop-portal.nix ← XDG desktop portal configuration
│   │   └── xserver.nix            ← X11 server configuration
│   └── scripts/                   ← Utility scripts
│       ├── ai/                       ← AI-powered tools (ask.sh, commit.sh)
│       ├── build/
│       │   ├── modules-check.sh  ← Module import validation
│       │   ├── sops/                      ← SOPS setup scripts
│       │   └── setup-keys.sh         ← SSH/GPG keys from SOPS
│       └── waybar/                   ← Waybar widgets
│           ├── gpu-combined.sh     ← GPU combined stats widget
│           ├── gpu-temp.sh           ← GPU temperature widget
│           └── network.sh            ← Network monitoring widget
├── secrets/                       ← Encrypted secrets (sops-nix)
│   ├── secrets.yaml
│   └── .sops.yaml
├── themes/                        ← Custom themes and wallpapers
│   ├── gruvbox.desktop-theme  ← Gruvbox GTK theme
│   ├── oxide.zsh-theme          ← ZSH oxide theme
│   └── wallpaper.png            ← Default wallpaper
├── AGENTS.md                      ← Guidelines for AI agents
├── CLAUDE.md                      ← Claude AI assistant configuration
├── .envrc                         ← Environment configuration
├── .gitignore                      ← Git ignore rules
├── flake.lock                      ← Locked dependency versions
├── flake.nix                       ← Main Nix flake configuration
├── justfile                        ← Task runner commands
└── README.md                      ← This file
```
