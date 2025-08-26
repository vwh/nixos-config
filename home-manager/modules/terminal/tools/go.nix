# Go programming language configuration

{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs = {
    go = {
      enable = true;
      package = pkgs.go;

      # Go environment variables
      goPath = "go";
      goBin = "go/bin";

      # Go private modules (if you have private repos)
      goPrivate = [ ];
    };

    # Zsh aliases for Go development
    zsh.shellAliases = {
      # Go development
      gorun = "go run";
      gobuild = "go build";
      gotest = "go test -v";
      gomod = "go mod";
      gofmt = "gofumpt -w";
      golint = "golangci-lint run";
      goair = "air";

      # Go debugging
      godebug = "dlv debug";
      gotrace = "dlv trace";
    };

    # Git ignore for Go projects
    git.ignores = [
      # Go specific
      "vendor/"
      "*.exe"
      "*.exe~"
      "*.dll"
      "*.so"
      "*.dylib"
      "*.test"
      "*.out"
      "go.work"
      "go.work.sum"
    ];
  };

  # Go LSP and development tools configuration
  home = {
    packages = with pkgs; [
      # Core Go tools
      gopls # Go language server
      go-tools # Collection of Go tools
      delve # Go debugger
      golangci-lint # Go linter
      air # Live reload for Go apps

      # Additional Go development tools
      gofumpt # Stricter gofmt
      golines # Go line formatter
      gotests # Generate Go tests
      impl # Generate interface implementations
      gomodifytags # Modify struct field tags
      govulncheck # Go vulnerability checker

      # Go utilities
      go-migrate # Database migration tool
      sqlc # Generate Go code from SQL
      protobuf # Protocol buffer compiler
      protoc-gen-go # Go protobuf generator
      protoc-gen-go-grpc # gRPC Go generator
    ];

    # Environment variables for Go development
    sessionVariables = {
      GOPATH = "${config.home.homeDirectory}/go";
      GOBIN = "${config.home.homeDirectory}/go/bin";
      GO111MODULE = "on";
      GOPROXY = "https://proxy.golang.org,direct";
      GOSUMDB = "sum.golang.org";
    };

    # Add Go bin to PATH
    sessionPath = [
      "${config.home.homeDirectory}/go/bin"
    ];

    # Create Go workspace directories
    activation.createGoWorkspace = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD mkdir -p $HOME/go/{bin,pkg,src}
      $DRY_RUN_CMD mkdir -p $HOME/projects/go
    '';
  };
}
