# AGENTS.md - Agent Guidelines for NixOS Configuration

This repository contains NixOS system configurations managed with Flakes.

---

## Build, Lint, and Format Commands

**Core Commands** (run with `just`):
| Command | Purpose |
|---------|---------|
| `just format` | Format all `.nix` files with `nixfmt --strict` |
| `just lint` | Lint Nix files (`statix`) + Bash scripts (`shellcheck`) |
| `just modules` | Check for missing module imports (**critical before commits**) |
| `just home` | Apply Home Manager config (safe user-level testing) |
| `just nixos` | Rebuild NixOS system with `nh os switch` |
| `just all` | Full pipeline: modules → lint → format → nixos → home |
| `just update` | Update all flake inputs |
| `just clean` | Clean artifacts & optimize Nix store |

**Secret Management** (SOPS):
| Command | Purpose |
|---------|---------|
| `just sops-edit` | Edit secrets (auto encrypt/decrypt via VS Code) |
| `just sops-view` | View decrypted secrets (read-only) |
| `just secrets-add key value` | Add single secret |
| `just sops-setup` | Initialize SOPS age key |

**Pre-commit Workflow:**
```bash
just modules   # Validate module structure
just lint      # Check code quality
just format    # Format Nix files
```

**Important Notes:**
- No traditional unit tests - this is a system config repo
- Module validation (`just modules`) is the primary test mechanism
- Use `nix eval .#nixosConfigurations.<hostname>.config.system.build.toplevel` to test config eval
- `nh` (Nix Helper) replaces `nixos-rebuild`
- Docker commands must run in `bash` (not `zsh`)
- LSP: `nixd` or `nil` for Nix language server

---

## Code Style Guidelines

### Nix Code Style

**Core Principles:**
- Use `inherit` for parameter passing: `{ user, ... }: { inherit user; }`
- Combine related attributes in attribute sets
- Use `lib.mkEnableOption` for boolean options
- Use `lib.mkOption` with `lib.types.*` for other types

**Import Pattern:**
- Auto-generated: `./hardware-configuration.nix`
- Host-specific: `./local-packages.nix`, `./modules/`
- Shared: `../../nixos/modules/`

**Module Pattern (mySystem namespace):**
```nix
{
  config, lib, ...
}:
{
  options.mySystem.featureName = {
    enable = lib.mkEnableOption "feature description";
  };
  config = lib.mkIf config.mySystem.featureName.enable { };
}
```

**Formatting:**
- Formatter: `nixfmt --strict` (RFC 166), 2-space indent, ~80-100 char lines, header comments

### Naming Conventions

- **Variables/Parameters:** `camelCase` (`hostname`, `stateVersion`, `gitConfig`)
- **Options:** `camelCase` with dot notation (`mySystem.gaming.enable`)
- **Files:** `kebab-case` (`gaming.nix`, `security.nix`, `modules-check.sh`)
- **Functions/Scripts:** `kebab-case` (`ai-ask`, `ai-help`, `extract()`, `mkcd()`)
- **Constants:** `SCREAMING_SNAKE_CASE` (Bash scripts only)

### Bash Script Style

**Required Header:** `#!/usr/bin/env bash` + `set -euo pipefail`
**Pattern:** Color constants, function-based architecture, guard clauses, loading animations

### Error Handling in Nix

```nix
# For assertions that must pass
config.assertions = [
  {
    assertion = condition;
    message = "Error message if condition is false";
  }
];

# For optional validation with warnings
warnings = lib.optional (deprecatedOption != null) "Option 'deprecatedOption' is deprecated";
```

### Module Organization

**System Modules** (`nixos/modules/`): Single responsibility, import through `default.nix`, always run `just modules` before committing

**Home Manager Modules** (`home-manager/modules/`): Grouped by function (`apps/`, `terminal/`, `languages/`, `hyprland/`), package aggregation through `home-manager/packages/`

### Custom mySystem Options

`mySystem.gaming.{enable,enableGamescope}` | Gaming (Steam, Lutris, Wine, Gamescope)
`mySystem.sandboxing.enable` | App sandboxing (Firejail, bubblewrap)
`mySystem.flatpak.enable` | Flatpak with Flathub
`mySystem.bluetooth.{enable,powerOnBoot}` | Bluetooth services
`mySystem.mullvadVpn.enable` | Mullvad VPN
`mySystem.tor.enable` | Tor network services
`mySystem.dnscryptProxy.enable` | DNSCrypt-Proxy
`mySystem.macchanger.enable` | MAC address randomization

---

## Architecture Patterns

**Factory Pattern** (flake.nix):
```nix
makeSystem = { hostname, stateVersion }:
  nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs stateVersion hostname user gitConfig pkgsStable; };
    modules = [ ./hosts/${hostname}/configuration.nix ];
  };
```

**Package Aggregation**:
```nix
{ pkgs, pkgsStable }:
let chunks = [ ./custom/prayer.nix ./applications.nix ./cli.nix ];
in builtins.concatLists (map (f: import f { inherit pkgs pkgsStable; }) chunks)
```

---

## Critical Rules

1. **Always run `just modules` before committing** - validates module structure
2. **Use `inherit` for parameter passing** - no exceptions
3. **Never suppress type errors** - no `as any`, `@ts-ignore`, etc.
4. **Never commit secrets** - use SOPS for secret management
5. **Combine related attributes** - don't scatter them
6. **Add descriptive header comments** to all new files
7. **Test with `just home` first** before `just nixos`

---

## Resources

[NixOS Options](https://search.nixos.org/options) | [Home Manager Options](https://nix-community.github.io/home-manager/options.html)
[NixOS Manual](https://nixos.org/manual/) | [Hyprland Wiki](https://hyprland.org/)
LSP: `nixd` or `nil`
