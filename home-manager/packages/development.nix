# List of development tools and languages to install.

{ pkgs, pkgsStable }:

(with pkgsStable; [
  # C/C++ development
  gcc # C compiler

  # Databases
  sqlite # SQLite database
  postgresql # PostgreSQL client
  redis # Redis client

  # Build tools and task runners
  just # Just command runner
  gnumake # GNU make
  cmake # CMake

  # Version control
  git-lfs # Git Large File Storage

  # Container and cloud tools
  docker-compose # Docker Compose

  # Database tools
  dbeaver-bin # Universal database tool

  # Debugging and profiling
  gdb # GNU Debugger
  valgrind # Memory debugger
  strace # System call tracer
  ltrace # Library call tracer

  # Documentation tools
  pandoc # Document converter
])

++ (with pkgs; [
  # Development
  vscode # Visual Studio Code
  sqlitebrowser # SQLite browser

  # API development and testing
  postman # API development platform
  bruno # (Postman alternative)
  insomnia # REST client

  # Programming languages
  openjdk23 # OpenJDK 23
  rustc # Rust compiler
  cargo # Cargo package manager
  go # Go programming language
  python3 # Python 3
  python3Packages.pip # Python package manager
  python3Packages.virtualenv # Python virtual environments

  # JavaScript/TypeScript
  nodejs # NodeJS JavaScript runtime
  bun # Bun JavaScript runtime
  deno # Deno JavaScript runtime
  pnpm # pnpm package manager
  yarn # Yarn package manager
])
