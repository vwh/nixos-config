# Development tools and programming languages for software development,
# debugging, database management, and reverse engineering.

{ pkgs, pkgsStable }:

[
  # === Integrated Development Environments ===
  pkgs.vscode # Visual Studio Code editor (use latest)
  pkgsStable.sqlitebrowser # SQLite database browser GUI

  # === API Development and Testing ===
  pkgsStable.burpsuite # Web application security testing tool
  pkgsStable.postman # API development platform
  pkgsStable.bruno # Open-source API client (Postman alternative)
  pkgsStable.insomnia # REST API client

  # === C/C++ Development ===
  pkgsStable.gcc # GNU C compiler and toolchain
  pkgsStable.gdb # GNU debugger
  pkgsStable.cmake # Cross-platform build system
  pkgsStable.gnumake # GNU make build automation
  pkgsStable.valgrind # Memory debugging and profiling
  pkgsStable.strace # System call tracer
  pkgsStable.ltrace # Library call tracer

  # === Database Systems and Clients ===
  pkgsStable.sqlite # SQLite database engine
  pkgsStable.postgresql # PostgreSQL database client
  pkgsStable.redis # Redis key-value store client
  pkgsStable.dbeaver-bin # Universal database management tool

  # === Build Systems and Task Runners ===
  pkgsStable.just # Modern command runner

  # === Version Control ===
  pkgsStable.git-lfs # Git Large File Storage

  # === Container and Orchestration ===
  pkgsStable.docker-compose # Docker container orchestration

  # === Documentation and Conversion ===
  pkgsStable.pandoc # Universal document converter

  # === Rust Development ===
  pkgs.rustc # Rust programming language compiler (use latest)
  pkgs.cargo # Rust package manager and build tool

  # === Java Development ===
  pkgsStable.openjdk21 # OpenJDK 21 LTS for Java development

  # === Reverse Engineering ===
  pkgsStable.ghidra # Reverse engineering framework
  pkgsStable.radare2 # Binary analysis tool
  pkgsStable.binwalk # Firmware analysis tool
  pkgsStable.cutter # GUI for radare2
  pkgsStable.apktool # Android APK analysis
  pkgsStable.jadx # Java decompiler
  pkgsStable.frida-tools # Dynamic instrumentation toolkit
  pkgsStable.android-tools # Android development tools for device interaction
]
