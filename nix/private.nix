{ pkgs, ... }:
{
  home-manager.users.patrick.home.packages = [ pkgs.ffmpeg ];

  homebrew = {
    casks = [
      "balenaetcher"
      "discord"
      "google-drive"
      "iina"
      "ledger-wallet"
      "lulu"
      "orbstack"
      "protonvpn"
      "whatsapp"
    ];
    masApps."Numbers" = 409203825;
  };
}
