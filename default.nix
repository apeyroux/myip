with import <nixpkgs> {};

let
  drv = haskell.packages.ghc883.callCabal2nix "myip" ./. {};
in if lib.inNixShell then drv.env.overrideAttrs (old: {
  buildInputs = old.buildInputs ++ [ haskellPackages.ghcid cabal-install ];
}) else drv
