{ mkDerivation, aeson, base, http-client, servant, servant-client
, stdenv
}:
mkDerivation {
  pname = "myip";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    aeson base http-client servant servant-client
  ];
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
