# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a comprehensive NixOS configuration repository using Nix Flakes to manage a complete Linux desktop environment. The configuration includes:

- **NixOS System**: Full system configuration with modular architecture
- **Home Manager**: User environment management with dotfiles and packages
- **Hyprland**: Wayland window manager with custom theming (Gruvbox)
- **Development Environments**: Isolated devShells for multiple programming languages
- **Secret Management**: SOPS-based encrypted secrets with age encryption

## Development Workflow

### Essential Commands

```bash
just lint           # Lint all .nix files with statix
just format         # Format all .nix files with nixfmt
just home           # Apply Home Manager configuration (safe)
just nixos          # Rebuild and switch NixOS system
just all            # Run full pipeline: check, lint, format, deploy
just modules        # Check for missing module imports
just update         # Update all flake inputs
```

### Testing Changes

1. **Lint and Format**: `just lint && just format`
2. **User Testing**: `just home` (applies user-level changes)
3. **System Testing**: `just nixos` (full system rebuild)

## Documentation and Help

### Manual Pages and System Information

```bash
# View NixOS configuration manual
man configuration.nix | col -bx

# Get help for specific options
nixos-option services.openssh.enable
nixos-option networking.hostName

# View Home Manager options
man home-configuration.nix | col -bx

# Check module documentation
cat nixos/modules/graphics.nix
cat home-manager/modules/default.nix
```

### Finding Options and Packages

```bash
nh search firefox           # Search packages
nh search "networking"      # Search NixOS options
nix search nixpkgs python   # Alternative package search
```

### Development Workflow

#### 1. Make Changes
- Edit `.nix` files in appropriate locations
- Follow existing module structure
- Add descriptive comments

#### 2. Test Changes
```bash
just lint && just format    # Code quality
just home                   # Safe user testing
just nixos                  # Full system (when ready)
```

### Quality Checklist

- [ ] `just lint` passes
- [ ] `just format` applied
- [ ] Documentation updated

## Architecture

### Flake Structure

- **`flake.nix`**: Central configuration defining hosts, users, and flake inputs
- **Special Args**: `inputs`, `stateVersion`, `hostname`, `user`, `gitConfig`, `pkgsStable`
- **Hosts**: `pc` (desktop), `thinkpad` (laptop)

### Configuration Organization

```
hosts/                      # Per-host system configurations
├── pc/                     # Desktop workstation
├── thinkpad/               # Laptop configuration
home-manager/               # User environment configuration
├── modules/                # Home Manager modules (apps, terminal, languages)
├── packages/               # User packages by category
nixos/modules/              # System-wide modules
├── audio.nix              # PipeWire/PulseAudio
├── graphics.nix           # GPU drivers
├── networking.nix         # Network configuration
├── virtualisation.nix     # Docker/VirtualBox
└── ...                    # Other system modules
```

### Module Architecture

**System Modules** (`nixos/modules/`):
- Each module handles a specific subsystem (audio, graphics, networking)
- Modules are imported through `default.nix` for clean separation
- Hardware-specific configurations live in host directories

**Home Manager Modules** (`home-manager/modules/`):
- User-specific configurations and dotfiles
- Grouped by function: `apps/`, `terminal/`, `languages/`, `hyprland/`
- Package aggregation through `packages/` directory

## Package Management

### Package Sets

- **`pkgs`**: Unstable packages (nixos-unstable)
- **`pkgsStable`**: Stable packages (nixos-25.05)
- Use stable for important tools, unstable for applications

### Adding Packages

**System Packages**: Add to appropriate file in `nixos/modules/`
**User Packages**: Add to relevant file in `home-manager/packages/`

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

### Module Organization Pattern

```nix
# Group related settings
networking = {
  hostName = "hostname";
  firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
  };
};
```

## Secret Management

Uses SOPS with age encryption:

```bash
just sops-setup    # Initialize age keys
just sops-edit      # Edit secrets (automatic encrypt/decrypt)
just sops-view      # View decrypted secrets
just secrets-add key value  # Add single secret
```

## Development Environments

Isolated devShells in `devShells/`:
- `bun/`, `deno/`, `go/`, `nodejs/`, `python-venv/`, `rust-stable/`, `rust-nightly/`

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

## Key Services and Features

- **Hyprland**: Wayland compositor with custom keybinds and styling
- **PipeWire**: Audio server with PulseAudio compatibility
- **Docker**: Container runtime
- **Ollama**: Local AI models (port 11434)
- **Qdrant**: Vector search engine (port 6333)
- **Glance**: System dashboard (port 8080)

## Common Development Tasks

### Adding New Host

1. Copy existing host: `cp -r hosts/pc new-hostname`
2. Copy hardware configuration from `/etc/nixos/hardware-configuration.nix`
3. Add to `hosts` list in `flake.nix`
4. Deploy: `sudo nixos-rebuild switch --flake .#new-hostname`

### Creating New Module

1. Create module file in appropriate directory
2. Add import to relevant `default.nix`
3. Test with `just home` or `just nixos`

### Updating Packages

```bash
just update    # Update all flake inputs
just clean     # Clean up old generations and optimize store
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

### Common Patterns
```bash
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

# Service configuration
services.openssh = {
  enable = true;
  ports = [ 22 ];
  settings = {
    PermitRootLogin = "no";
  };
};

# Module organization
networking = {
  hostName = "hostname";
  firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
  };
};
```

## Important Notes

- This is a personal system configuration with specific hardware and user setups
- Always test changes with `just home` before running `just nixos`
- Use stable packages for important tools, unstable for user applications
- Follow existing module patterns and naming conventions
- All changes should be tested and formatted before committing
- The `just` command runner provides all essential development tasks
- Use `nh` (Nix Helper) for advanced operations like searching and rollback