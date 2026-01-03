# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a comprehensive NixOS configuration repository using Nix Flakes to manage a complete Linux desktop environment. The configuration includes:

- **NixOS System**: Full system configuration with modular architecture
- **Home Manager**: User environment management with dotfiles and packages
- **Hyprland**: Wayland window manager with custom theming (Gruvbox)
- **Development Environments**: Isolated devShells for multiple programming languages
- **Secret Management**: SOPS-based encrypted secrets with age encryption
- **AI Integration**: Local AI models (Ollama) and vector search (Qdrant) for intelligent development
- **AI Tools**: Command-line AI assistants with GLM-4.6 model integration

## Quick Start

For immediate setup on a new machine:

```bash
# Clone and apply configuration
git clone git@github.com:vwh/nixos-config.git ~/System
cd ~/System
just all  # Runs full pipeline: modules check, lint, format, nh os switch, home-manager switch
```

The `just` command runner provides all essential development tasks - run `just` to see all available commands.

## Development Workflow

### Essential Commands

```bash
just lint           # Lint all .nix files with statix + bash shellcheck
just format         # Format all .nix files with nixfmt
just modules        # Check for missing module imports (critical before commits)
just home           # Apply Home Manager configuration using nh (safe, user-level only)
just nixos          # Rebuild and switch NixOS system using nh (full system rebuild)
just all            # Run full pipeline: modules check, lint, format, nh os switch, home-manager switch
just update         # Update all flake inputs
just clean          # Clean up old generations and optimize store using nh
```

### Testing Changes

**Development Workflow:**
1. **Make changes** to `.nix` files in appropriate locations
2. **Check imports**: `just modules` (validates module structure)
3. **Code quality**: `just lint && just format`
4. **User testing**: `just home` (safe, applies user-level changes only)
5. **System testing**: `just nixos` (full system rebuild when ready)

**Critical Rule**: Always run `just modules` before committing - it catches missing imports and broken references.

## Architecture

### Flake Structure and Factory Pattern

- **`flake.nix`**: Central configuration using factory function `makeSystem` to generate host configurations
- **Special Args**: `inputs`, `stateVersion`, `hostname`, `user`, `gitConfig`, `pkgsStable`
- **Hosts**: `pc` (desktop), `thinkpad` (laptop)

**Key Design Pattern**: The flake uses a factory function `makeSystem` combined with `foldl'` to generate NixOS and Home Manager configurations for each host from a single `hosts` list, ensuring consistency while allowing host-specific customizations (hostname, stateVersion, monitorConfig).

```nix
# Factory pattern implementation
makeSystem = { hostname, stateVersion }:
  nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs stateVersion hostname user gitConfig pkgsStable; };
    modules = [ ./hosts/${hostname}/configuration.nix ];
  };
```

### Configuration Organization

```
hosts/                      # Per-host system configurations
├── pc/                     # Desktop workstation
│   ├── modules/            # Host-specific modules
│   ├── local-packages.nix  # Host-specific packages
│   └── configuration.nix   # Main host config
├── thinkpad/               # Laptop configuration
home-manager/               # User environment configuration
├── modules/                # Home Manager modules (apps, terminal, languages)
│   ├── apps/              # Application-specific configs
│   ├── hyprland/          # Window manager with sub-modules
│   ├── languages/         # Programming language setups
│   └── terminal/          # Terminal and shell configs
├── packages/              # User packages by category (aggregated)
└── home.nix               # Main home configuration
nixos/modules/              # System-wide modules
├── audio.nix              # PipeWire/PulseAudio
├── cleanup.nix            # Automated cleanup services for downloads, cache, pip, npm, docker, etc.
├── flatpak.nix            # Flatpak sandboxed application support with Flathub
├── gaming.nix             # Steam, Lutris, Wine, MangoHud (with Gamescope option)
├── graphics.nix           # GPU drivers
├── networking.nix         # Network configuration
├── ollama.nix             # Local AI models (port 11434)
├── qdrant.nix             # Vector search (port 6333)
├── sandboxing.nix         # Firejail and bubblewrap for application sandboxing
├── security.nix           # Kernel hardening, auto-updates, weekly Lynis audits
├── nh.nix                 # Nix Helper configuration
└── virtualisation.nix     # Docker/libvirt
```

### Module Architecture

**System Modules** (`nixos/modules/`):
- Each module handles a specific subsystem (audio, graphics, networking, AI services)
- Modules are imported through `default.nix` for clean separation
- Hardware-specific configurations live in host directories
- AI services (Ollama, Qdrant) are properly networked and firewalled

**The `mySystem` Namespace Pattern**:

Several modules use a custom `mySystem` options namespace for enabling optional features:

```nix
# Example: Enable optional features in host configuration
mySystem.gaming.enable = true;
mySystem.gaming.enableGamescope = true;  # Optional sub-feature
mySystem.sandboxing.enable = true;       # Application sandboxing with Firejail
```

Available `mySystem` options:
- `mySystem.gaming.enable` - Gaming support (Steam, Lutris, Wine, MangoHud)
- `mySystem.gaming.enableGamescope` - Optional Gamescope compositor session
- `mySystem.sandboxing.enable` - Application sandboxing (Firejail, bubblewrap)

**Home Manager Modules** (`home-manager/modules/`):
- User-specific configurations and dotfiles
- Grouped by function: `apps/`, `terminal/`, `languages/`, `hyprland/`
- Package aggregation through `packages/` directory using sophisticated flattening

## Package Management

### Package Sets

- **`pkgs`**: Unstable packages (nixos-unstable)
- **`pkgsStable`**: Stable packages (nixos-25.05)
- Use stable for important tools, unstable for applications

### Adding Packages

**System Packages**: Add to appropriate file in `nixos/modules/`
**User Packages**: Add to relevant file in `home-manager/packages/`

```nix
# System packages
environment.systemPackages = with pkgs; [
  firefox        # Web browser
  vscode         # Code editor
];

# User packages (Home Manager)
home.packages = with pkgs; [
  htop          # System monitor
  git           # Version control
];
```

### Package Aggregation Pattern

Home Manager uses sophisticated package aggregation:
```nix
# Multiple package chunks flattened into single list
builtins.concatLists (map (f: import f { inherit pkgs pkgsStable; }) chunks)
```

## Gaming Module

The gaming module (`nixos/modules/gaming.nix`) provides Steam, Lutris, Wine, and MangoHud support with optional Gamescope:

```nix
# Enable gaming (in host configuration)
mySystem.gaming.enable = true;
mySystem.gaming.enableGamescope = true;  # Optional: Enable Gamescope session
```

**Note**: The `mySystem` namespace is a custom options pattern used for organizing optional system features. This pattern allows for clean, hierarchical configuration of major subsystems.

Includes: Steam with Proton-GE, Lutris with FHS environment and Wine dependencies, MangoHud overlay, wineWowPackages, winetricks.

## Service Configuration

### AI Services
| Service | Port | Purpose |
|---------|------|---------|
| **Ollama** | 11434 | Local AI models and embeddings |
| **Qdrant** | 6333 | Vector search for code indexing |

### Web Services
| Service | Port | Purpose |
|---------|------|---------|
| **Glance Dashboard** | 8080 | System monitoring dashboard |
| **CUPS Print Server** | 631 | Printer management |

### System Security Module
- **Security Hardening**: Comprehensive security module with kernel hardening (SYN cookies, reverse path filtering), automatic daily updates, weekly Lynis security audits via systemd timer, and AppArmor confinement
- Configuration: `nixos/modules/security.nix`
- PAM limits: Increased file descriptors (1048576) for gaming/Wine, disabled core dumps, real-time priority support

### Automated Cleanup Services
- **Cleanup Module**: Systemd timers for automatic maintenance of downloads, cache, and language-specific package caches
- Configuration: `nixos/modules/cleanup.nix`
- Services include:
  - `cleanup-telegram-downloads` (daily, 14+ days old)
  - `cleanup-downloads` (weekly, 30+ days old)
  - `cleanup-screenshots` (monthly, 14+ days old)
  - `cleanup-cache` (weekly, 30+ days old)
  - `cleanup-pip-cache`, `cleanup-npm-cache`, `cleanup-bun-cache`, `cleanup-go-cache` (monthly/weekly)
  - `cleanup-playwright` (monthly)
  - `cleanup-telegram-desktop` (monthly, 60+ days old)
  - `cleanup-docker` (monthly, full system prune)

### Application Sandboxing
- **Sandboxing Module**: Firejail and bubblewrap for application containment
- Configuration: `nixos/modules/sandboxing.nix`
- Enable with `mySystem.sandboxing.enable = true;`
- Includes Firejail profiles, bubblewrap (bwrap), and squashfs tools
- Note: Some Firejail profiles (librewolf, tor-browser) are disabled due to NixOS path incompatibilities

### Flatpak Support
- **Flatpak Module**: Sandboxed application distribution with automatic Flathub setup
- Configuration: `nixos/modules/flatpak.nix`
- Automatically adds Flathub remote on first build via systemd service
- Use `flatpak install flathub <app>` to install applications

### Nix Helper (nh) Integration
- **Nix Helper**: Modern Nix management tool with improved build and switch operations
- Commands: `nh os switch`, `nh home switch`, `nh clean all`
- Configuration: `nixos/modules/nh.nix`
- FLAKE environment variable: Automatically set to `/home/yazan/System`, so you can run `nh os switch` without specifying the flake path
- Shortcut: With FLAKE set, `nh os switch .` is equivalent to running from the System directory

### Service Configuration Pattern

```nix
services.openssh = {
  enable = true;
  ports = [ 22 ];
  settings = {
    PermitRootLogin = "no";
  };
};
```

## Secret Management

Uses SOPS with age encryption:

```bash
just sops-setup    # Initialize age keys
just sops-edit      # Edit secrets in VS Code (automatic encrypt/decrypt)
just sops-view      # View decrypted secrets (read-only)
just sops-decrypt   # Decrypt secrets to file for manual editing
just sops-encrypt   # Encrypt file back to secrets.yaml
just sops-key       # Show SOPS public age key
just secrets-add key value  # Add single secret
just setup-keys     # Setup SSH and GPG keys from SOPS secrets
```

## Development Environments

Isolated devShells in `devShells/` with flake templates:

Available templates:
- **`bun/`** - Bun JavaScript/TypeScript runtime with project initialization
- **`deno/`** - Deno secure JavaScript/TypeScript runtime
- **`go/`** - Go development environment
- **`nodejs/`** - Node.js with npm/yarn/pnpm package managers
- **`python-venv/`** - Python with virtual environment support
- **`rust-stable/`** - Rust stable toolchain with cargo
- **`rust-nightly/`** - Rust nightly toolchain for bleeding-edge features

**Usage**: `nix flake init -t "github:vwh/nixos-config/main?dir=devShells#<name>"`

### Docker Commands

Docker commands should be run in bash (not zsh) due to password configuration:
```bash
# Use bash for Docker operations
bash -c "docker ps"
bash -c "docker build -t myapp ."
```

## Code Style Guidelines

### Nix Code Style

#### Use `inherit` for flake parameters
```nix
# Correct
{ user, ... }: {
  inherit user;
}

# Wrong
{ user, ... }: {
  user = user;
}
```

#### Combine related attributes
```nix
# Correct
environment = {
  systemPackages = [ ... ];
  sessionVariables = { ... };
};

# Wrong
environment.systemPackages = [ ... ];
environment.sessionVariables = { ... };
```

#### General Guidelines
- Use `inherit` for parameter passing: `{ user, ... }: { inherit user; }`
- Combine related attributes in attribute sets
- Add descriptive comments explaining module purpose
- Follow existing module structure and naming conventions

### Module Organization

- Each module should have a clear, single responsibility
- Use descriptive file names that indicate functionality
- Import modules through `default.nix` files for clean interfaces

## Key Features and Integration

### AI-Powered Development Environment
- **Ollama Service**: Local AI models and embeddings (port 11434)
- **Qdrant Vector Search**: AI-powered code indexing (port 6333)
- **AI Assistant Scripts**: Integrated AI utilities for enhanced development workflow
- **Language Server Support**: Complete LSP setups for all major languages

#### AI Development Tools

The repository includes sophisticated AI-powered utilities in `scripts/ai/`:

**`ai-ask`** - General-purpose AI assistant:
```bash
./scripts/ai/ask.sh "Explain quantum computing"           # Query AI (GLM-4.6)
./scripts/ai/ask.sh -d "Complex analysis task"          # Same model, explicit deep mode flag
./scripts/ai/ask.sh -c "Generate command"               # Copy to clipboard
./scripts/ai/ask.sh -s "You are expert" "Help me"       # Custom system prompt
```

**`ai-help`** - Command-line assistant:
```bash
./scripts/ai/help.sh "how to list files"                # Gets "ls -la" (auto-copied)
./scripts/ai/help.sh "find large files"                 # Gets practical Linux commands
./scripts/ai/help.sh "compress folder"                  # Ready-to-use commands
```

**`ai-commit`** - Intelligent commit message generation:
```bash
./scripts/ai/commit.sh                                  # Analyzes staged changes
./scripts/ai/commit.sh -d                               # Use deep model for better analysis
```

These tools integrate with the z.ai OpenAI-compatible API service using GLM-4.6 and provide context-aware assistance for NixOS development, conventional commits, and command-line operations.

### Gesture-Based Launcher
- **Hexecute**: Gesture-based application launcher with mouse gesture recognition
- Integration: Hyprland keybind (`$mainMod, SPACE, exec, hexecute`)
- Package: Included in host-specific packages

### Advanced Window Manager Integration
- **Hyprland with UWSM**: Universal Wayland Session Manager integration
- **Custom Keybinds**: Extensive Hyprland configuration
- **Status Bar**: Waybar with custom widgets (GPU temp, network monitoring)
- **Notification System**: SwayNC integration

### Multi-Language Development Support
- **JavaScript/TypeScript**: Complete toolchain with multiple runtimes (Node.js, Bun, Deno)
- **Python**: Development environment with virtualization support
- **Go**: Full toolchain with package management
- **Language Servers**: Comprehensive LSP support across all languages

## Common Development Tasks

### Adding New Host

1. Copy existing host: `cp -r hosts/pc new-hostname`
2. Copy hardware configuration from `/etc/nixos/hardware-configuration.nix`
3. Add to `hosts` list in `flake.nix`
4. Deploy: `sudo nixos-rebuild switch --flake .#new-hostname`

### Creating New Module

1. Create module file in appropriate directory (`nixos/modules/` or `home-manager/modules/`)
2. Add import to relevant `default.nix`
3. **Critical**: Run `just modules` to validate import structure
4. Test with `just home` or `just nixos`

**For optional system-level features**, consider using the `mySystem` namespace pattern:

```nix
# In your module (e.g., nixos/modules/myfeature.nix)
{ config, lib, ... }:
{
  options.mySystem.myfeature.enable = lib.mkEnableOption "my feature description";

  config = lib.mkIf config.mySystem.myfeature.enable {
    # Your configuration here
  };
}
```

Then enable in host configuration with `mySystem.myfeature.enable = true;`.

### Updating Packages

```bash
just update    # Update all flake inputs
just clean     # Clean up old generations and optimize store
```

### Module Validation

The `just modules` command runs `scripts/build/modules-check.sh` which:
- Validates that all `.nix` files in directories with `default.nix` are properly imported
- Catches missing imports and broken file references
- Essential for maintaining module structure integrity

```bash
# Example validation output
⟳ Checking ./nixos/modules/default.nix
✗  Missing import: ./nixos/modules/new-module.nix
➤ Found 1 import error(s).
```

## Troubleshooting

### Build Issues

```bash
nh os build . --verbose      # Debug build with verbose output
journalctl -u nixos-rebuild-switch-to-configuration.service  # Logs
```

### Service Problems

```bash
systemctl status <service>
journalctl -u <service>
```

### Rollback

```bash
nh os rollback              # System rollback
home-manager switch --rollback  # Home configuration rollback
```

## Key Resources

### Official Documentation
- [NixOS Options](https://search.nixos.org/options)
- [NixOS Packages](https://search.nixos.org/packages)
- [Home Manager Options](https://nix-community.github.io/home-manager/options.html)
- [NixOS Manual](https://nixos.org/manual/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Hyprland Wiki](https://hyprland.org/)

### Useful Tools
- **nh**: Nix Helper - `nh search`, `nh os build/switch/rollback`
- **nixpkgs-fmt**: Nix code formatter (used by `just format`)
- **statix**: Nix linter (used by `just lint`)
- **nixos-option**: Query NixOS options
- **home-manager**: Home Manager CLI tool

### Community Resources
- [NixOS Discourse](https://discourse.nixos.org/)
- [NixOS Matrix Chat](https://matrix.to/#/#nix:nixos.org)
- [NixOS Subreddit](https://www.reddit.com/r/NixOS/)

## Important Notes

- This is a personal system configuration with specific hardware (`pc` desktop, `thinkpad` laptop) and user (`yazan`) setups
- **Critical workflow**: `just modules && just lint && just format` before any commit
- **Always test changes with `just home` before running `just nixos`** - user-level changes are safer to test
- **Use `nh` (Nix Helper) for all Nix operations** - it replaces direct `nixos-rebuild` and `home-manager` commands
- Module import validation (`just modules`) prevents broken configurations
- **Docker password**: Use `bash` for Docker commands, not zsh (configured password: `alice`)