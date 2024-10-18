{
  description = "MPRIS2 Discord music rich presence status with support for album covers and progress bar.";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux =
      let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
      in {
        mpris-discord-rpc = pkgs.callPackage ./package.nix {};
      };
  };
}
