set shell := ["/usr/bin/env", "bash", "-c"]
set quiet

JUST_EXECUTABLE := "just -u -f " + justfile()
header := "Available tasks:\n"

_default:
    @{{JUST_EXECUTABLE}} --list-heading "{{header}}" --list

# Switch to a new home-manager generation
home:
    home-manager switch --flake '.?submodules=1'

# Switch to a new nixos generation
nixos:
    sudo nixos-rebuild switch --flake .

# Switch both, home and nixos
both: nixos && home
