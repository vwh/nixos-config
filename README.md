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
.
├── home-manager/                  ← Home-Manager configuration
│   ├── modules/                   ← reusable home-manager modules (e.g. zsh, git)
│   ├── packages/                  ← grouped package lists for Home-Manager
│   └── home.nix                   ← entrypoint loading your user modules
├── hosts/                         ← per-host NixOS configurations
│   ├── pc/                        ← “pc” host (configuration.nix, hardware config, etc.)
│   └── thinkpad/                  ← “thinkpad” host
├── nix-templates/                 ← project-flake templates for various runtimes
│   ├── .../                       ← project templates
│   ├── flake.lock                 ← locked inputs for all templates
│   └── flake.nix                  ← root flake defining the templates
├── nixos/                         ← shared NixOS modules
│   └── modules/                   ← reusable NixOS modules (networking, users, etc.)
├── secrets/                       ← sensitive files (e.g. SSL certs, API keys)
├── flake.lock                     ← locked inputs for the root flake
├── flake.nix                      ← root flake (all inputs & outputs for your config)
├── justfile                       ← project tasks & shortcuts (build, deploy, fmt…)
└── modules-check.sh               ← script to validate your Nix modules
```
