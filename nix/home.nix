{
  config,
  pkgs,
  profile,
  ...
}:
let
  home = config.home.homeDirectory;
  # out-of-store links keep files editable in the repo and writable by apps that save their own settings
  link = path: config.lib.file.mkOutOfStoreSymlink "${home}/dotfiles/${path}";
in
{
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    ansible
    atuin
    bashInteractive
    bat
    choose
    cmake
    delta
    eza
    fd
    fzf
    gh
    git
    git-crypt
    gnugrep
    htop
    ijq
    jq
    just
    lazygit
    mise
    ncdu
    neovim
    oh-my-zsh
    ripgrep
    ssh-copy-id
    starship
    tree
    watch
    wget
    zoxide
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];

  home.file = {
    ".agents/AGENTS.md".source = link "agents/AGENTS.md";
    ".agents/AGENTS.local.md".source = link "agents/AGENTS.local.md";
    ".agents/skills/review-notes".source = link "agents/skills/review-notes";

    ".claude/CLAUDE.md".source = link "agents/AGENTS.md";
    ".claude/settings.json".source = link "claude/settings.json";
    ".claude/statusline-command.sh".source = link "claude/statusline-command.sh";
    ".claude/hooks".source = link "claude/hooks";
    ".claude/skills/review-notes".source = link "agents/skills/review-notes";

    ".codex/AGENTS.md".source = link "agents/AGENTS.md";
    ".codex/config.toml".source = link "codex/config.toml";
    ".codex/hooks.json".source = link "codex/hooks.json";

    ".config/atuin/config.toml".source = link "atuin/config.toml";
    ".config/eza/theme.yml".source = link "eza/themes/nord.yml";
    ".config/ghostty/config".source = link "ghostty/config";
    ".config/ghostty/shaders".source = link "ghostty/shaders";
    ".config/herdr/config.toml".source = link "herdr/config.toml";
    ".config/hunk/config.toml".source = link "hunk/config.toml";
    ".config/mise/config.toml".source = link "mise/config.toml";
    ".config/nvim".source = link "nvim";
    ".config/zed/settings.json".source = link "zed/settings.json";
    "Library/Application Support/Code/User/settings.json".source = link "vscode/settings.json";

    ".gitconfig".source = link "git/.gitconfig";
    ".gitignore_global".source = link "git/.gitignore_global";
    ".git_functions".source = link "git/.git_functions";
    ".gitconfig_user".source = link "git/.gitconfig_${profile}";

    ".gnupg/gpg-agent.conf".source = link "gnupg/gpg-agent.conf";

    ".ssh/config".source = link "ssh/config";
    ".ssh/config_profile_specific".source = link "ssh/config_${profile}";
    ".ssh/private.pub".source = link "ssh/private.pub";
    ".ssh/work.pub".source = link "ssh/work.pub";
    ".ssh/id_ed25519.pub".source = link "ssh/${profile}.pub";
    # private key is fetched from 1Password by ssh/install.sh
    ".ssh/id_ed25519".source = config.lib.file.mkOutOfStoreSymlink "${home}/.ssh/${profile}.priv";

    ".starship/starship.toml".source = link "starship/starship.toml";
    ".starship/helper/aws_sso_expired_check.sh".source = link "starship/helper/aws_sso_expired_check.sh";

    ".zshrc".source = link "zsh/.zshrc";
    ".zshrc_profile_specific".source = link "zsh/.zshrc_${profile}";
  };
}
