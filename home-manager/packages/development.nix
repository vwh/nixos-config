# Development tools and programming languages.
# This module provides essential development tools, programming languages,
# databases, and debugging utilities for software development.

{ pkgs, pkgsStable }:

(with pkgsStable; [
  # C/C++ development toolchain
  gcc # GNU C compiler and toolchain

  # Database systems and clients
  sqlite # SQLite database engine
  postgresql # PostgreSQL database client
  redis # Redis key-value store client

  # Build systems and task runners
  just # Modern command runner
  gnumake # GNU make build automation
  cmake # Cross-platform build system

  # Version control enhancements
  git-lfs # Git Large File Storage

  # Container and orchestration tools
  docker-compose # Docker container orchestration

  # Database management tools
  dbeaver-bin # Universal database management tool

  # Debugging and profiling tools
  gdb # GNU debugger
  valgrind # Memory debugging and profiling
  strace # System call tracer
  ltrace # Library call tracer

  # Documentation and conversion tools
  pandoc # Universal document converter
])

++ (with pkgs; [
  # Integrated Development Environments
  vscode # Visual Studio Code editor
  sqlitebrowser # SQLite database browser GUI

  # API development and testing tools
  postman # API development platform
  bruno # Open-source API client (Postman alternative)
  insomnia # REST API client

  # Programming language runtimes and toolchains
  openjdk23 # OpenJDK 23 for Java development
  rustc # Rust programming language compiler
  cargo # Rust package manager and build tool
])
