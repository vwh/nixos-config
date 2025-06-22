# NixOS System Configurations

This repository contains my NixOS system configurations.

---

## Quickstart

1. Clone the repo:

   ```bash
   git clone https://github.com/vwh/nixos-config.git ~/System
   cd ~/System
   ```

2. Create your host stub:

   ```bash
   cd hosts
   cp -r pc <your-hostname>
   ```

3. Copy in your hardware configuration:

   ```bash
   cp /etc/nixos/hardware-configuration.nix hosts/<your-hostname>/
   ```

4. Tweak host-specific and shared settings:

   • `hosts/<your-hostname>/local-packages.nix`  
   • `nixos/modules/.../*.nix`  
   • `home-manager/home.nix` & `home-manager/packages/*.nix`

5. Edit `flake.nix`:

   ```diff
   ...
       outputs = { self, nixpkgs, home-manager, ... }@inputs: let
       system = "x86_64-linux";
   --  homeStateVersion = "25.05";
   ++  homeStateVersion = "<your_home_manager_state_version>";
   --  user = "yazan";
   ++  user = "<your_username>";
       hosts = [
   --    { hostname = "pc"; stateVersion = "25.05"; }
   --    { hostname = "thinkpad"; stateVersion = "25.05"; }
   ++    { hostname = "<your_hostname>"; stateVersion = "<your_state_version>"; }
       ];
   ...
   ```

6. Deploy your NixOS host:

   ```bash
   sudo nixos-rebuild switch --flake ~/System#<your-hostname>
   #sudo nixos-rebuild switch --flake ~/System/#pc
   ```

7. Apply Home-Manager for your user:

   ```bash
   home-manager switch --flake ~/System#<your_username>
   #home-manager switch --flake ~/System/#yazan
   ```

---

## Layout

```text
├── flake.nix                      ← root flake (all inputs & outputs)
├── flake.lock                     ← locked inputs for the root flake
│
├── home-manager/                  ← Home-Manager configuration
│   ├── home.nix                   ← entrypoint for user modules
│   ├── modules/                   ← reusable modules (e.g. zsh, git)
│   └── packages/                  ← grouped package lists
│
├── hosts/                         ← per-host NixOS configurations
│   ├── pc/                        ← “pc” host
│   │   ├── configuration.nix      ← main NixOS config
│   │   ├── hardware-configuration.nix
│   │   └── local-packages.nix     ← host-specific package overrides
│
├── nixos/                         ← shared NixOS modules
│   └── modules/...
```

---

## TODO

### Window Manager & UI

- [x] Hyprland (Wayland compositor)
- [x] Notification daemon (mako/dunst)
- [x] Rofi + theming

### Shell & Prompt

- [x] Z-Shell with plugins & themes

### Editors & IDEs

- [ ] Nix-powered Neovim (`nixvim`)
- [ ] VSCode + extensions

### Infrastructure

- [x] Multi-host management
- [x] Tor integration (system + browser)
- [ ] Secrets management

### Utilities & Tools

- [x] Modern CLI (`exa`, `fd`, `bat`)
- [x] Clipboard tools (`wl-clipboard` / `xclip`)

### Flake & Nix Improvements

- [x] Split large `home-packages.nix` into categories
- [ ] Abstract common overlays
- [ ] Document each module
