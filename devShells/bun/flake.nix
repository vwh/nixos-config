# Nix flake for a Bun JavaScript application.
{
  description = "Bun Javascript App";

  inputs = {
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      utils,
    }:

    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell = pkgs.mkShell {
          name = "bun-app";
          buildInputs = with pkgs; [ bun ];

          shellHook = ''
            # Initialize Bun project if no package.json exists
            if [ ! -f package.json ]; then
              echo "📦 No package.json found. Initializing Bun project..."
              bun init --yes
            else
              echo "🟢 Bun development environment ready!"
              echo "   bun install    # Install dependencies"
              echo "   bun run dev    # Start development server"
              echo "   bun build      # Build project"
              echo "   bun test       # Run tests"
            fi
          '';
        };
      }
    );
}
