{ pkgs, ... }:
{
  home-manager.users.patrick.home.packages = with pkgs; [
    kcat
    pulumi-bin
  ];

  homebrew = {
    taps = [
      "bufbuild/buf"
      "keidarcy/tap"
    ];
    # docker stack stays in brew: colima runs as a brew service and the CLI plugins rely on brew's layout
    brews = [
      {
        name = "colima";
        restart_service = "changed";
      }
      "docker"
      "docker-buildx"
      "docker-compose"
      {
        name = "libpq";
        link = true;
      }
      "mosquitto"
      "bufbuild/buf/buf"
      "keidarcy/tap/e1s"
    ];
    casks = [
      "aws-vpn-client"
      "granola"
      "postico"
      "pycharm"
      "session-manager-plugin"
    ];
    masApps."Numbers" = 361304891;
    extraConfig = ''
      uv "ebx"
    '';
  };
}
