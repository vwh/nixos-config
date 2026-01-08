# NixOS Configuration Knowledge Base

**Generated:** 2026-01-08
**Mode:** Update (existing AGENTS.md preserved)

## OVERVIEW
NixOS Flake-based system + home-manager configs for 2 hosts (pc, thinkpad). Hyprland WM, Gruvbox theme, AI dev tools, SOPS secrets.

## STRUCTURE
```
./
├── hosts/              # Per-host NixOS configs (pc, thinkpad)
│   ├── <host>/configuration.nix    # Host entry point
│   ├── <host>/hardware-configuration.nix  # Auto-generated
│   └── <host>/modules/             # Host-specific modules
├── nixos/modules/      # System modules (36 files)
├── home-manager/        # User environment
│   ├── modules/         # HM modules (40 files)
│   └── packages/       # Package categories (12 chunks)
├── devShells/          # Language templates (7 flakes)
├── scripts/            # Utility scripts
│   ├── ai/             # AI assistants (ask, help, commit)
│   └── build/          # modules-check.sh validation
└── flake.nix          # Factory pattern: makeSystem/makeHomeConfig
```

## WHERE TO LOOK
| Task | Location | Notes |
|-------|-----------|-------|
| System settings | `nixos/modules/` | Audio, networking, gaming, security, etc. |
| User apps/configs | `home-manager/modules/` | Terminal, languages, hyprland, apps |
| Add system package | `nixos/modules/<topic>.nix` | Follow mySystem namespace pattern |
| Add user package | `home-manager/packages/<category>.nix` | Categories: applications, cli, development, etc. |
| New host | `hosts/<new>/` + update flake.nix hosts list | Copy hardware-config |
| Host-specific tweaks | `hosts/<host>/modules/` | Thinkpad: nvidia, tlp, boot |
| AI tools | `scripts/ai/` | ask.sh, help.sh, commit.sh |
| Module validation | `scripts/build/modules-check.sh` | Runs via `just modules` |

## CONVENTIONS (Project-Specific)

### mySystem Namespace Pattern
Custom options for modular feature toggles:
```nix
mySystem.gaming.{enable,enableGamescope}
mySystem.sandboxing.{enable,enableUserNamespaces,enableWrappedBinaries}
mySystem.flatpak.enable
mySystem.bluetooth.{enable,powerOnBoot}
mySystem.mullvadVpn.enable
mySystem.tor.enable
mySystem.dnscryptProxy.enable
mySystem.macchanger.enable
```

### Factory Pattern (flake.nix)
`makeSystem` + `foldl'` generates configs for all hosts from single `hosts` list. SpecialArgs: `inputs`, `stateVersion`, `hostname`, `user`, `gitConfig`, `pkgsStable`.

### Package Aggregation (HM)
`home-manager/packages/default.nix` uses `builtins.concatLists (map (f: import f) chunks)` pattern for 12 package categories.

### Inherit for Parameter Passing
`{ user, ... }: { inherit user; }` - never use `user = user;`

### Module Structure
System modules: `nixos/modules/<feature>.nix` → imported in `default.nix`
HM modules: `home-manager/modules/<category>/default.nix` → imports submodules

### Module Validation
`just modules` runs `scripts/build/modules-check.sh` - validates all `.nix` files in directories with `default.nix` are imported. **Critical before commits.**

### nh (Nix Helper)
Replaces `nixos-rebuild`: `nh os switch .`, `nh home switch`. `NH_FLAKE` env var set to `/home/yazan/System`.

## ANTI-PATTERNS (This Project)

### Forbidden Patterns
- **Never** enable both PulseAudio and PipeWire (assertion enforces this)
- **Never** use wildcard WiFi interfaces (`wlp*`) in Avahi - use specific names only
- **Never** run multiple power management daemons (TLP conflicts with power-profiles-daemon, thermald, auto-cpufreq)
- **Never** use nouveau when proprietary NVIDIA enabled (blacklisted)
- **Never** use NixOS channels with flakes (channel disabled)
- **Never** use broken packages (allowBroken = false in flake.nix)

### Critical Battery Settings (ThinkPad)
Charging thresholds: START_CHARGE_THRESH_BAT0 = 75, STOP_CHARGE_THRESH_BAT0 = 80 (battery longevity).
NVIDIA finegrained power management: 30-50% battery savings.

### Service Conflicts
- Firejail librewolf/tor-browser profiles: Disabled (NixOS path incompatibility)
- Prometheus node exporter: Removed (service failures)
- Custom package overlays: Removed (use official packages instead)

### Disabled Features
- `home-manager/modules/hyprland/hypridle.nix`: Auto-suspend commented out (37-min timeout)
- `nixos/modules/stability.nix`: Prometheus monitoring removed

## COMMANDS

### Development Workflow
```bash
just modules   # Validate module imports (CRITICAL)
just lint      # statix + shellcheck
just dead      # deadnix unused code scan
just format    # nixfmt-tree (optimized)
just check     # nix flake check --no-build
just home      # Test user-level changes (safe)
just nixos     # Apply system changes
just all       # Full pipeline: modules → lint → dead → format → check → nixos → home
```

### Maintenance
```bash
just update    # Update all flake inputs
just clean     # Clean Nix store (nh clean all --keep 1)
```

### Secrets (SOPS)
```bash
just sops-edit      # Edit in VS Code (auto encrypt/decrypt)
just sops-view      # View decrypted
just secrets-add key value
```

## NOTES

### Testing Strategy
1. `just home` first (safe, user-level)
2. `just nixos` only when ready (system rebuild)
3. No traditional unit tests - module validation is primary test

### Docker Commands
Must run in `bash` (not `zsh`) due to password configuration.

### Two Package Sets
- `pkgs`: Unstable (nixos-unstable)
- `pkgsStable`: Stable (nixos-25.11)
- Use stable for important tools, unstable for applications

### devShells Usage
Templates in `devShells/flake.nix` - init with `nix flake init -t "github:vwh/nixos-config/main?dir=devShells#<name>"`

### Theme Assets
Custom themes in `themes/` (gruvbox, oxide.zsh-theme, wallpaper). Stylix applies Gruvbox system-wide.

### Hardware-Specific Modules
- Thinkpad only: `nvidia.nix` (Optimus), `tlp.nix` (power), `boot.nix` (bootloader + kernel params)
- PC only: `power.nix` (power-profiles-daemon)

### Module Import Validation
`scripts/build/modules-check.sh` catches missing imports and broken file references. Run `just modules` before every commit.

### Git Signing
Commits signed with GPG key `0x5478BB36AC504E64` (gitConfig defined in flake.nix).

### Service Ports
- Qdrant: 6333 (vector search)
- Glance: 8080 (dashboard)
- CUPS: 631 (printing)
- Tor: 9050 (system), 9150 (Tor Browser)

### GPU Temperature Thresholds
WARNING: 70°C, CRITICAL: 85°C (scripts/waybar/gpu-temp.sh)

### Cleanup Services (systemd timers)
Downloads: 30+ days old, screenshots: 14+ days, telegram-desktop: 60+ days, docker: monthly full prune. npm/bun/pip/go caches: weekly/monthly.
