{
  description = "Bun Javascript App";

  inputs = {
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
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
          buildInputs = with pkgs; [
            bun
          ];

          shellHook = ''
            if [ ! -f package.json ]; then
              bun init
            fi
          '';
        };
      }
    );
}
