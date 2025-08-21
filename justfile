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

# Check system health
health:
	@echo -e "\n➤ Checking system health…"
	@echo "Disk usage:"
	@df -h
	@echo -e "\nNix store info:"
	@timeout 10s du -sh /nix/store 2>/dev/null || echo "Nix store size: $(df -h /nix | tail -1 | awk '{print $3 "/" $2 " (" $5 " used)"}')"
	@echo -e "\nMemory usage:"
	@free -h

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