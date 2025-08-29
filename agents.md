# Agent Guide - NixOS Configuration

## Quick Reference

### Essential Commands
```bash
just lint           # Check code quality
just format         # Format Nix files
just home           # Test user changes (safe)
just nixos          # Full system rebuild
just all            # Complete pipeline
```

### Finding Options & Packages
```bash
nh search firefox           # Search packages
nh search "networking"      # Search NixOS options
nix search nixpkgs python   # Alternative package search
```

### Documentation & Help
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

### Code Quality
```bash
just lint                   # Primary linting
```

## Development Workflow

### 1. Make Changes
- Edit `.nix` files in appropriate locations
- Follow existing module structure
- Add descriptive comments

### 2. Test Changes
```bash
just lint && just format    # Code quality
just home                   # Safe user testing
just nixos                  # Full system (when ready)
```

## Project Structure

```
hosts/pc/configuration.nix          # Host-specific config
home-manager/modules/               # User modules
nixos/modules/                      # System modules
home-manager/packages/              # Package collections
```

## Common Patterns

### Adding Packages
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
```

### Service Configuration
```bash
services.openssh = {
  enable = true;
  ports = [ 22 ];
  settings = {
    PermitRootLogin = "no";
  };
};
```

### Module Organization
```bash
# Group related settings
networking = {
  hostName = "hostname";
  firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
  };
};
```

## Linting Rules

### Use `inherit` for flake parameters
```bash
# Correct
{ user, ... }: {
  inherit user;
}

# Wrong
{ user, ... }: {
  user = user;
}
```

### Combine related attributes
```bash
# Correct
environment = {
  systemPackages = [ ... ];
  sessionVariables = { ... };
};

# Wrong
environment.systemPackages = [ ... ];
environment.sessionVariables = { ... };
```

## Troubleshooting

### Build Issues
```bash
nh os build . --verbose      # Debug build
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
```

## Key Resources

- [NixOS Options](https://search.nixos.org/options)
- [NixOS Packages](https://search.nixos.org/packages)
- [Home Manager Options](https://nix-community.github.io/home-manager/options.html)

## Quality Checklist

- [ ] `just lint` passes
- [ ] `just format` applied
- [ ] `just home` works
- [ ] Changes tested
- [ ] Documentation updated