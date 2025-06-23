set shell := ["/usr/bin/env", "bash", "-c"]
set quiet

JUST_EXECUTABLE := "just -u -f " + justfile()
header := "Available tasks:\n"

_default:
    @{{JUST_EXECUTABLE}} --list-heading "{{header}}" --list

# Switch to a new home-manager generation
home:
    home-manager switch --flake '.?submodules=1'

# Format all .nix files
format:
    find . -type f -name '*.nix' -exec nixfmt {} +

# Switch to a new nixos generation
nixos:
    sudo nixos-rebuild switch --flake .

# Switch both, home and nixos
both:
    just format && just nixos && just home