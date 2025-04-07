{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.services.mpris-discord-rpc;
  mpris-discord-rpc = pkgs.callPackage ./package.nix { };
in
{
  options.services.mpris-discord-rpc = {
    enable = lib.mkEnableOption ''
      Whether to enable mpris-discord-rpc, an MPRIS2 Discord music rich presence status service.
    '';
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ mpris-discord-rpc ];

    systemd.user.services."mpris-discord-rpc" = {
      Unit = {
        Description = "MPRIS2 Discord music rich presence status";
        After = "network.target";
      };
      Service = {
        ExecStart = "${lib.getExe mpris-discord-rpc}";
        Restart = "always";
        RestartSec = 10;
        StandardOutput = "journal";
        StandardError = "journal";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
