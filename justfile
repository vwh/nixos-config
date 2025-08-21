set shell := ["/usr/bin/env", "bash", "-c"]
set quiet

JUST := "just -u -f " + justfile()
header := "Available tasks:\n"

_default:
    @{{JUST}} --list-heading "{{header}}" --list

# Format all .nix files
format:
    @echo -e "\n➤ Formatting Nix files…"
    find . -type f -name '*.nix' -exec nixfmt {} +

# Lint all .nix files
lint:
    @echo -e "\n➤ Linting Nix files…"
    nix run nixpkgs#statix check
    @echo "✔ Linting passed!"

# Check all missing imports
modules:
    @echo -e "\n➤ Checking modules…"
    bash ./scripts/build/modules-check.sh

# Switch Home-Manager generation
home:
    @echo -e "\n➤ Switching Home-Manager…"
    home-manager switch --flake '.?submodules=1'

# Switch NixOS generation
nixos:
    @echo -e "\n➤ Rebuilding NixOS…"
    sudo nixos-rebuild switch --flake .

# Update all flake inputs
update:
	nix flake update

# Optimize Nix store
optimize-store:
	nix store optimise

# Clean up build artifacts and caches
clean:
	@echo -e "\n➤ Cleaning up build artifacts and caches…"
	nix-collect-garbage --delete-older-than 1d
	nix store optimise
	@echo -e "✅ Cleanup completed!"

# Check system health
health:
	@echo -e "\n➤ Checking system health…"
	@echo "Disk usage:"
	@df -h
	@echo -e "\nNix store info:"
	@timeout 10s du -sh /nix/store 2>/dev/null || echo "Nix store size: $(df -h /nix | tail -1 | awk '{print $3 "/" $2 " (" $5 " used)"}')"
	@echo -e "\nMemory usage:"
	@free -h

# Edit secrets with SOPS
sops-edit:
    @echo -e "\n➤ Editing secrets with SOPS…"
    @echo "Decrypting secrets..."
    @sops --decrypt secrets/secrets.yaml > secrets/secrets-decrypted.yaml
    @echo "Opening VS Code (close the tab/window when done editing)..."
    @code --wait secrets/secrets-decrypted.yaml
    @echo "Encrypting secrets back..."
    @sops --encrypt secrets/secrets-decrypted.yaml > secrets/secrets.yaml
    @rm secrets/secrets-decrypted.yaml
    @echo "✅ Encrypted and cleaned up!"

# View decrypted secrets (read-only)
sops-view:
	@echo -e "\n➤ Viewing decrypted secrets…"
	sops --decrypt secrets/secrets.yaml

# Decrypt secrets to file for manual editing
sops-decrypt:
	@echo -e "\n➤ Decrypting secrets to secrets/secrets-decrypted.yaml…"
	sops --decrypt secrets/secrets.yaml > secrets/secrets-decrypted.yaml
	@echo "Edit secrets/secrets-decrypted.yaml then run: just sops-encrypt"

# Encrypt file back to secrets
sops-encrypt:
	@echo -e "\n➤ Encrypting secrets/secrets-decrypted.yaml to secrets/secrets.yaml…"
	sops --encrypt secrets/secrets-decrypted.yaml > secrets/secrets.yaml
	@rm secrets/secrets-decrypted.yaml
	@echo "✅ Encrypted and cleaned up!"

# Add a single secret
secrets-add key value:
	@echo -e "\n➤ Adding secret: {{key}} = {{value}}"
	sops --set '["{{key}}"] "{{value}}"' secrets/secrets.yaml
	@echo "✅ Secret added!"

# Setup SOPS age key
sops-setup:
	@echo -e "\n➤ Setting up SOPS age key…"
	./scripts/sops-setup.sh

# Setup SSH and GPG keys from SOPS
setup-keys:
	@echo -e "\n➤ Setting up SSH and GPG keys from SOPS…"
	./scripts/setup-keys.sh

# Show SOPS public key
sops-key:
	@echo -e "\n➤ SOPS public key:"
	@sops --version && echo ""
	@if [ -f ~/.config/sops/age/keys.txt ]; then \
		echo "Public key:"; \
		nix shell nixpkgs#age -c age-keygen -y ~/.config/sops/age/keys.txt; \
	else \
		echo "No age key found. Run 'just sops-setup' to create one."; \
	fi

# All of the above, in order
all:
    @echo -e "\n➤ Running full pipeline…"
    {{JUST}} modules
    {{JUST}} lint
    {{JUST}} format
    {{JUST}} nixos
    {{JUST}} home
    @echo -e "✅ All done!"

# Initialize global packages
init-npm:
    @echo -e "\n➤ Initializing global packages..."
    ./scripts/npm/mkdir-npm-global.sh
    ./scripts/npm/install-global-packages.sh
    @echo -e "✅ Global packages initialized!"

# Install global packages
install-npm:
    @echo -e "\n➤ Installing global packages..."
    ./scripts/npm/install-global-packages.sh
    @echo -e "✅ Global packages installed!"

# Update global packages
update-npm:
	@echo -e "\n➤ Updating global packages..."
	bun update -g
	@echo -e "✅ Global packages updated!"