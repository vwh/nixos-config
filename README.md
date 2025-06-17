# .dotfiles

My NixOS system configuration.

---

## Getting Started

Clone your repo:

```bash
git clone https://github.com/vwh/.dotfiles ~/System
cd ~/System
```

### 1. Rebuild system

```bash
sudo nixos-rebuild switch --flake ~/System/#pc
```

### 2. Switch Home-Manager config

```bash
home-manager switch --flake ~/System/#yazan
```

---

## Layout

```text
System/
├── flake.nix                    # top-level flake
├── nixos/
│   ├── configuration.nix        # yConfig
│   ├── hardware-configuration.nix
│   ├── modules/                 # NixOS-module fragments
│   └── packages.nix             # Shared package sets
└── home-manager/
    ├── home.nix                 # Home-Manager config
    └── modules/                 # home-manager module fragments
```

---

## TODO

### Containers & Databases

- [ ] Docker
- [ ] Redis
- [ ] MongoDB
- [ ] PostgreSQL

### Window Manager & UI

- [ ] Hyperland (Wayland compositor)
- [ ] Screenshot & clipboard integration
- [ ] Rofi (application launcher) + theming / rice

### Shell & Prompt

- [ ] Better Z shell (plugins, themes, autosuggestions)
- [ ] Notification daemon (e.g. `dunst` or `mako`)

### Languages & Runtimes

- [ ] Python
- [ ] Bun
- [ ] Go
- [ ] Deno
- [ ] Cloudflare CLI (`wrangler`)
- [ ] npm / Node.js
- [ ] Zig

### Browsers & Extensions

- [ ] Browser extensions management

### Editors & IDEs

- [ ] Nix-powered Vim/Neovim (`nixvim` with plugins)
- [ ] VSCode vscode-extensions

### Infrastructure

- [ ] Hosts management
- [ ] `tor` integration (system+browser)
- [ ] Secrets management

### Utilities & Tools

- [ ] Modern CLI tools (e.g. `exa`, `fd`, `bat`)
- [ ] Notification daemon (mako/dunst)
- [ ] Clipboard tool (wl-clipboard/xclip)
- [ ] Rice support (dotfile theming)

### Flake & Nix Structure

- [ ] Split large `packages.nix` into per-category files
- [ ] Abstract common overlays
- [ ] Document each module’s purpose
