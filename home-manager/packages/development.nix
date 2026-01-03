# Development tools and programming languages for software development,
# debugging, database management, and reverse engineering.

{ pkgs, pkgsStable }:

with pkgs;
with pkgsStable;
[
  # === Integrated Development Environments ===
  vscode # Visual Studio Code editor
  zed-editor # Zed editor
  sqlitebrowser # SQLite database browser GUI

  # === API Development and Testing ===
  burpsuite # Web application security testing tool
  postman # API development platform
  bruno # Open-source API client (Postman alternative)
  insomnia # REST API client

  # === C/C++ Development ===
  gcc # GNU C compiler and toolchain
  gdb # GNU debugger
  cmake # Cross-platform build system
  gnumake # GNU make build automation
  valgrind # Memory debugging and profiling
  strace # System call tracer
  ltrace # Library call tracer

  # === Database Systems and Clients ===
  sqlite # SQLite database engine
  postgresql # PostgreSQL database client
  redis # Redis key-value store client
  dbeaver-bin # Universal database management tool

  # === Build Systems and Task Runners ===
  just # Modern command runner

  # === Version Control ===
  git-lfs # Git Large File Storage

  # === Container and Orchestration ===
  docker-compose # Docker container orchestration

  # === Documentation and Conversion ===
  pandoc # Universal document converter

  # === Rust Development ===
  rustc # Rust programming language compiler
  cargo # Rust package manager and build tool

  # === Java Development ===
  openjdk21 # OpenJDK 21 LTS for Java development

  # === Reverse Engineering ===
  ghidra # Reverse engineering framework
  radare2 # Binary analysis tool
  binwalk # Firmware analysis tool
  cutter # GUI for radare2
  apktool # Android APK analysis
  jadx # Java decompiler
  frida-tools # Dynamic instrumentation toolkit
  android-tools # Android development tools for device interaction
]
