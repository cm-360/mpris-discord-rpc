{ lib
, rustPlatform
, dbus
, openssl
, pkg-config
,
}:

rustPlatform.buildRustPackage rec {
  pname = "mpris-discord-rpc";
  version = "0.1.5";

  src = lib.cleanSource ./.;

  cargoLock = {
    lockFile = ./Cargo.lock;
    allowBuiltinFetchGit = true;
  };

  postUnpack = ''
    cp ${./.env.example} .env
    sed -i 's/key-here/REPLACE-WITH-KEY/g' .env
  '';

  buildInputs = [
    dbus
    openssl
  ];

  nativeBuildInputs = [
    pkg-config
  ];

}
