# NixOS System Configurations

This repository contains my personal NixOS system configurations, managed with Nix Flakes.

![image](https://github.com/user-attachments/assets/07ba2010-ce96-486b-ad55-521b58691c91)

---

## Daily Workflow

This repository uses `just` as a command runner to simplify common tasks.

*   **`just`**: List all available commands.
*   **`just all`**: Run the full pipeline: check, lint, format, and deploy both NixOS and Home-Manager.
*   **`just nixos`**: Rebuild and switch to the new NixOS generation for the current host.
*   **`just home`**: Apply the latest Home-Manager generation for the user `yazan`.
*   **`just format`**: Format all `.nix` files with `nixfmt`.
*   **`just lint`**: Lint all `.nix` files with `statix`.
*   **`just modules`**: Check for missing module imports.
*   **`just update`**: Update all flake inputs.

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
│   └── home.nix                   ← entrypoint loading your user modules
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
├── flake.nix                      ← root flake (all inputs & outputs for your config)
├── justfile                       ← project tasks & shortcuts (build, deploy, fmt…)
└── modules-check.sh               ← script to validate your Nix modules
```
