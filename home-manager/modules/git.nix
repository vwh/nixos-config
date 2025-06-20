{
  programs.git = {
    enable = true;
    userName = "vwh";
    userEmail = "vwhe@proton.me";

    ignores = [
      ".cache/"
      ".DS_Store"
      ".idea/"
      "*.swp"
      "*.elc"
      "auto-save-list"
      ".direnv/"
      "node_modules"
      "result"
      "result-*"
    ];
  };
}
