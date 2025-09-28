# Python programming language configuration.
# This module configures Python development environment with tools,
# package management, LSP support, and project workspace setup.

{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs = {
    # Python development aliases
    zsh.shellAliases = {
      # Python execution
      py = "python3"; # Run Python 3
      py2 = "python2"; # Run Python 2 (if available)
      pyi = "python3 -i"; # Interactive Python
      pym = "python3 -m"; # Run Python module

      # Package management (pip)
      pipi = "pip install"; # Install package
      pipu = "pip install --upgrade"; # Upgrade package
      pipr = "pip uninstall"; # Remove package
      pipl = "pip list"; # List installed packages
      pipf = "pip freeze"; # Show installed packages
      pipreq = "pip install -r requirements.txt"; # Install from requirements
      pipfreeze = "pip freeze > requirements.txt"; # Freeze to requirements

      # Package management (uv) - faster alternative to pip
      uvi = "uv pip install"; # Install package with uv
      uvu = "uv pip install --upgrade"; # Upgrade package with uv
      uvr = "uv pip uninstall"; # Remove package with uv
      uvl = "uv pip list"; # List installed packages with uv
      uvf = "uv pip freeze"; # Show installed packages with uv
      uvreq = "uv pip install -r requirements.txt"; # Install from requirements with uv
      uvfreeze = "uv pip freeze > requirements.txt"; # Freeze to requirements with uv
      uvinit = "uv init"; # Initialize uv project
      uvadd = "uv add"; # Add dependency to uv project
      uvdev = "uv add --dev"; # Add dev dependency to uv project
      uvrun = "uv run"; # Run script with uv
      uvsync = "uv sync"; # Sync dependencies with uv

      # Virtual environments
      venvc = "python3 -m venv venv"; # Create virtual environment
      venva = "source venv/bin/activate"; # Activate virtual environment
      venvd = "deactivate"; # Deactivate virtual environment
      venvi = "venv/bin/pip install"; # Install in virtual environment

      # Code quality and development tools
      blackf = "black --line-length 88"; # Format with Black
      isortf = "isort --profile black"; # Sort imports with isort
      flake8l = "flake8 --max-line-length 88"; # Lint with flake8
      mypyl = "mypy --ignore-missing-imports"; # Type check with mypy
      pytestr = "pytest -v"; # Run tests with pytest
      pytestrw = "pytest -v --tb=short"; # Run tests with short traceback
      coverage = "coverage run -m pytest && coverage report"; # Run tests with coverage

      # Jupyter notebooks
      jupyterl = "jupyter lab"; # Start Jupyter Lab
      jupytern = "jupyter notebook"; # Start Jupyter Notebook
    };

    # Git ignore patterns for Python projects
    git.ignores = [
      # Byte-compiled / optimized / DLL files
      "__pycache__/" # Python cache
      "*.py[cod]" # Compiled Python
      "*$py.class" # Cython compiled

      # C extensions
      "*.so" # Shared object files

      # Distribution / packaging
      ".Python" # Python distribution
      "build/" # Build directory
      "develop-eggs/" # Development eggs
      "dist/" # Distribution packages
      "downloads/" # Downloaded packages
      "eggs/" # Egg packages
      ".eggs/" # Egg packages
      "parts/" # Buildout parts
      "sdist/" # Source distribution
      ".installed.cfg" # Buildout configuration
      "*.egg-info/" # Egg info
      ".installed.cfg" # Buildout
      "*.egg" # Egg packages
      "MANIFEST" # Manifest file

      # PyInstaller
      "*.manifest" # PyInstaller manifest
      "*.spec" # PyInstaller spec

      # Installer logs
      "pip-log.txt" # pip log
      "pip-delete-this-directory.txt" # pip cleanup

      # Unit test / coverage reports
      "htmlcov/" # Coverage HTML report
      ".tox/" # tox testing
      ".coverage" # Coverage data
      ".coverage.*" # Coverage data
      "cache" # Coverage cache
      "nosetests.xml" # Nose test XML
      "coverage.xml" # Coverage XML
      "*.cover" # Coverage files
      ".hypothesis/" # Hypothesis test data

      # Translations
      "*.mo" # Compiled translations
      "*.pot" # Translation templates

      # Django stuff:
      "*.log" # Django logs
      "local_settings.py" # Local Django settings
      "db.sqlite3" # SQLite database
      "db.sqlite3-journal" # SQLite journal

      # Flask stuff:
      "instance/" # Flask instance folder
      ".webassets-cache" # Flask webassets cache

      # Scrapy stuff:
      ".scrapy" # Scrapy configuration

      # Sphinx documentation
      "docs/_build/" # Sphinx build directory

      # PyBuilder
      "target/" # PyBuilder target

      # Jupyter Notebook
      ".ipynb_checkpoints" # Jupyter checkpoints

      # IPython
      "profile_default/" # IPython profile
      "ipython_config.py" # IPython config

      # pyenv
      ".python-version" # pyenv version

      # pipenv
      "Pipfile.lock" # pipenv lock file

      # PEP 582
      "__pypackages__/" # PEP 582 packages

      # Celery stuff
      "celerybeat-schedule" # Celery beat schedule
      "celerybeat.pid" # Celery beat PID

      # SageMath parsed files
      "*.sage.py" # SageMath parsed files

      # Environments
      ".env" # Environment variables
      ".venv" # Virtual environment
      "env/" # Virtual environment
      "venv/" # Virtual environment
      "ENV/" # Virtual environment
      "env.bak/" # Backup virtual environment
      "venv.bak/" # Backup virtual environment

      # Spyder project settings
      ".spyderproject" # Spyder project
      ".spyproject" # Spyder project

      # Rope project settings
      ".ropeproject" # Rope project

      # mkdocs documentation
      "/site" # mkdocs site

      # mypy
      ".mypy_cache/" # mypy cache
      ".dmypy.json" # mypy daemon
      "dmypy.json" # mypy daemon

      # Pyre type checker
      ".pyre/" # Pyre type checker

      # PyCharm
      ".idea/" # PyCharm IDE

      # VSCode
      ".vscode/" # VSCode IDE

      # OS generated files
      ".DS_Store" # macOS
      ".DS_Store?" # macOS
      "._*" # macOS
      ".Spotlight-V100" # macOS
      ".Trashes" # macOS
      "ehthumbs.db" # Windows
      "Thumbs.db" # Windows
    ];
  };

  # Python development environment configuration
  home = {
    # Essential Python development packages - organized by category
    packages = with pkgs; [
      # Core Python
      python3 # Python 3 interpreter

      # Package management
      python3Packages.pip # Python package installer
      python3Packages.virtualenv # Virtual environment manager
      poetry # Python dependency management
      pipenv # Alternative virtual environment management
      uv # Fast Python package installer and resolver

      # Code quality and development tools
      python3Packages.black # Code formatter
      python3Packages.isort # Import sorter
      python3Packages.flake8 # Linter
      python3Packages.mypy # Type checker
      python3Packages.pytest # Testing framework
      python3Packages.coverage # Coverage tool
      python3Packages.setuptools # Packaging
      python3Packages.wheel # Wheel builder
      python3Packages.bandit # Security linter
      python3Packages.safety # Security vulnerability checker
      python3Packages.vulture # Dead code detection

      # LSP and IDE support
      python3Packages.python-lsp-server # Python LSP server
      python3Packages.pylsp-mypy # MyPy plugin for Python LSP
      python3Packages.pyls-isort # isort plugin for Python LSP
      python3Packages.pyls-flake8 # flake8 plugin for Python LSP

      # Enhanced REPL and debugging
      python3Packages.ipython # Enhanced Python shell
      python3Packages.ptpython # Better Python REPL
      python3Packages.pudb # Python debugger
      python3Packages.pytest-cov # Coverage plugin for pytest
      python3Packages.pytest-xdist # Parallel test execution

      # Data science and scientific computing
      python3Packages.numpy # Numerical computing
      python3Packages.pandas # Data analysis
      python3Packages.matplotlib # Plotting library
      python3Packages.scipy # Scientific computing
      python3Packages.scikit-learn # Machine learning
      python3Packages.jupyterlab # Jupyter Lab interface
      python3Packages.notebook # Jupyter Notebook

      # Web development frameworks
      python3Packages.django # Django web framework
      python3Packages.flask # Flask web framework
      python3Packages.fastapi # FastAPI web framework
      python3Packages.uvicorn # ASGI server

      # HTTP and async libraries
      python3Packages.requests # HTTP library
      python3Packages.urllib3 # HTTP library (dependency)
      python3Packages.aiohttp # Async HTTP client

      # Database connectors
      python3Packages.sqlalchemy # SQL toolkit
      python3Packages.psycopg2 # PostgreSQL adapter
      python3Packages.pymongo # MongoDB driver
      python3Packages.redis # Redis client

      # Documentation
      python3Packages.sphinx # Documentation generator
      python3Packages.mkdocs # Markdown documentation

      # Cloud and deployment
      python3Packages.boto3 # AWS SDK
      python3Packages.docker # Docker SDK
      python3Packages.kubernetes # Kubernetes client

      # Automation and SSH tools
      python3Packages.fabric # SSH automation
      python3Packages.ansible # Configuration management
      python3Packages.paramiko # SSH client
    ];

    # Environment variables for Python development - organized by tool
    sessionVariables = {
      # Python core configuration
      PYTHONPATH = "${config.home.homeDirectory}/Projects/python"; # Python path for local packages
      PYTHONSTARTUP = "${config.home.homeDirectory}/.pythonrc"; # Python startup script
      PYTHONUTF8 = "1"; # Enable UTF-8 mode by default
      PYTHONLEGACYWINDOWSSTDIO = ""; # Disable legacy Windows stdio handling on Unix

      # Virtual environment settings
      VIRTUAL_ENV_DISABLE_PROMPT = "1"; # Don't modify prompt in virtual environments

      # Jupyter configuration
      JUPYTER_CONFIG_DIR = "${config.home.homeDirectory}/.jupyter"; # Jupyter config directory
      JUPYTER_PLATFORM_DIRS = "1"; # Use platform-specific directories

      # Package manager configurations
      POETRY_VIRTUALENVS_IN_PROJECT = "true"; # Create virtual environments in project directory
      POETRY_NO_INTERACTION = "1"; # Non-interactive mode
      POETRY_PYPI_TOKEN_PYPI = ""; # PyPI token (set via secrets)

      PIP_DISABLE_PIP_VERSION_CHECK = "1"; # Disable pip version check
      PIP_NO_WARN_SCRIPT_LOCATION = "1"; # Don't warn about script location
      PIP_INDEX_URL = ""; # Custom PyPI index (set via secrets if needed)

      UV_CACHE_DIR = "${config.xdg.cacheHome}/uv"; # uv cache directory
      UV_PYTHON_INSTALL_DIR = "${config.xdg.dataHome}/uv/python"; # uv Python installations
      UV_COMPILE_BYTECODE = "1"; # Compile bytecode for faster startup
      UV_LINK_MODE = "copy"; # How to link packages (copy for better isolation)

      # Development and testing
      PYTHONDEVMODE = ""; # Enable Python development mode (set to '1' for debugging)
      PYTHONWARNINGS = "default"; # Show deprecation warnings
    };

    # Add Python binaries to system PATH
    sessionPath = [
      "${config.home.homeDirectory}/.local/bin" # Local Python packages
      "${config.home.homeDirectory}/.poetry/bin" # Poetry binaries
    ];

    # Automatic workspace directory creation and Python setup
    activation.createPythonWorkspace = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
            # Create Python project directories
            $DRY_RUN_CMD mkdir -p $HOME/Projects/{python,django,flask,fastapi,data}
            $DRY_RUN_CMD mkdir -p $HOME/.jupyter

            # Create Python startup script if it doesn't exist
            if [[ ! -f $HOME/.pythonrc ]]; then
              $DRY_RUN_CMD cat > $HOME/.pythonrc << 'PYTHONRC_EOF'
      import atexit
      import os
      import readline
      import rlcompleter

      # Enable tab completion
      readline.parse_and_bind("tab: complete")

      # History file
      history_file = os.path.expanduser("~/.python_history")
      if os.path.exists(history_file):
        readline.read_history_file(history_file)
      atexit.register(readline.write_history_file, history_file)

      # Set history length
      readline.set_history_length(1000)

      # Enable colors in Python REPL
      os.environ['PYTHON_COLORS'] = '1'
      PYTHONRC_EOF
            fi
    '';
  };
}
