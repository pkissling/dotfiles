{ profile, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 6;
  system.primaryUser = "patrick";
  users.users.patrick.home = "/Users/patrick";

  # Determinate Nix manages the nix daemon itself
  nix.enable = false;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "pre-nix";
    extraSpecialArgs = { inherit profile; };
    users.patrick = ./home.nix;
  };

  programs.zsh = {
    enable = true;
    # oh-my-zsh runs compinit itself
    enableCompletion = false;
    # starship owns the prompt
    promptInit = "";
  };

  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true;
  };

  system.defaults = {
    NSGlobalDomain.ApplePressAndHoldEnabled = false;
    CustomUserPreferences = {
      "com.microsoft.VSCode".ApplePressAndHoldEnabled = false;
      "com.jetbrains.intellij".ApplePressAndHoldEnabled = false;
    };
  };

  nix-homebrew = {
    enable = true;
    user = "patrick";
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
    taps = [
      "supabase/tap"
      "umputun/apps"
    ];
    # gnupg/pinentry stay in brew: git and gpg-agent configs point at /opt/homebrew/bin
    brews = [
      "gnupg"
      "mas"
      "mole"
      "pinentry-mac"
      "supabase/tap/supabase"
      "umputun/apps/revdiff"
    ];
    casks = [
      "1password"
      "1password-cli"
      "boop"
      "claude"
      "codex"
      "firefox"
      "font-jetbrains-mono-nerd-font"
      "ghostty"
      "google-chrome"
      "gpg-suite"
      "linear"
      "macshot"
      "obsidian"
      "raycast"
      "slack"
      "spotify"
      "tailscale-app"
      "thaw"
      "todoist-app"
      "visual-studio-code"
      "zed"
    ];
    masApps = {
      "1Password for Safari" = 1569813296;
      "The Unarchiver" = 425424353;
      "Xcode" = 497799835;
    };
    vscode = [
      "anthropic.claude-code"
      "arcticicestudio.nord-visual-studio-code"
      "ms-python.debugpy"
      "ms-python.python"
      "ms-python.vscode-pylance"
      "ms-python.vscode-python-envs"
      "ms-vscode.remote-explorer"
      "ms-vscode.remote-server"
      "vscodevim.vim"
    ];
  };
}
