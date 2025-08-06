# NixOS System Configurations

This repository contains my personal NixOS system configurations, managed with Nix Flakes. It features a complete desktop environment with Hyprland compositor, beautiful Gruvbox theming, and extensive development tooling.

![Desktop Screenshot](https://github.com/user-attachments/assets/a1facebb-61a9-4978-9405-9614af918a2b)

---

##  Quick Start

### Installation
```bash
# Clone the repository
git clone https://github.com/vwh/nixos-config.git ~/System
cd ~/System

# Apply the configuration
just all  # or follow the step-by-step process below
```

## Daily Workflow

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

---

## Secrets Management

This configuration uses `sops-nix` for managing secrets.

*   To edit a secret file, run: `sops secrets/<file_name>.yaml`

---

## Onboarding a New Machine

1.  **Clone the repo:**
    ```bash
    git clone https://github.com/vwh/nixos-config.git ~/System
    cd ~/System
    ```

2.  **Create the host configuration:**
    ```bash
    cd hosts
    cp -r pc <new-hostname>
    ```

3.  **Copy the hardware configuration:**
    ```bash
    cp /etc/nixos/hardware-configuration.nix hosts/<new-hostname>/
    ```

4.  **Add the new host to `flake.nix`:**
    Open `flake.nix` and add your new host to the `hosts` list.

5.  **Deploy the system:**
    ```bash
    # For the new host
    sudo nixos-rebuild switch --flake ~/System#<new-hostname>

    # For home-manager
    home-manager switch --flake ~/System#yazan
    ```

---

## Layout

```text
.
├── home-manager/                  ← Home-Manager configuration
│   ├── modules/                   ← reusable home-manager modules (e.g. zsh, git)
│   ├── packages/                  ← grouped package lists for Home-Manager
│   └── home.nix                   ← entrypoint loading the user modules
├── hosts/                         ← per-host NixOS configurations
│   ├── pc/                        ← “pc” host (configuration.nix, hardware config, etc.)
│   └── thinkpad/                  ← “thinkpad” host
├── devShells/                     ← project-flake templates
│   ├── .../                       ← project templates
│   ├── flake.lock                 ← locked inputs for all templates
│   └── flake.nix                  ← root flake defining the templates
├── nixos/                         ← shared NixOS modules
│   └── modules/                   ← reusable NixOS modules (networking, users, etc.)
├── secrets/                       ← sensitive files (e.g. SSL certs, API keys)
├── flake.lock                     ← locked inputs for the root flake
├── flake.nix                      ← root flake (all inputs & outputs for the config)
├── justfile                       ← project tasks & shortcuts (build, deploy, fmt…)
├── scripts/                       ← Utility scripts
│   ├── build/                     ← Build-related scripts
│   ├── npm/                       ← NPM setup scripts
│   └── waybar/                    ← Waybar helper scripts
├── secrets/                       ← Encrypted secrets (sops-nix)
├── flake.nix                      ← Main flake configuration
├── flake.lock                     ← Locked dependency versions
├── justfile                       ← Task runner commands
```

### Key Directories Explained

- **`home-manager/`** - User-space configuration managed by Home-Manager
- **`hosts/`** - Machine-specific system configurations
- **`devShells/`** - Isolated development environments for different languages
- **`nixos/modules/`** - Reusable system-level modules
- **`secrets/`** - Encrypted configuration files using sops-nix
- **`themes/`** - Custom application themes matching the Gruvbox aesthetic