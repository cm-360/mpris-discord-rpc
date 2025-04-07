{
  description = "MPRIS2 Discord music rich presence status with support for album covers and progress bar.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = rec {
          mpris-discord-rpc = pkgs.callPackage ./package.nix { };
          default = mpris-discord-rpc;
        };
      }
    )
    // {
      homeManagerModules.default = import ./hm-module.nix;
    };
}
