{ pkgs, ... }:

let
  fetchPackage = pkg: pkgs.fetchFromGitHub {
    owner = builtins.elemAt (builtins.splitString "/" pkg.repo) 0; # lhs of "repo"
    repo = builtins.elemAt (builtins.splitString "/" pkg.repo) 1; # rhs of "repo"
    rev = pkg.rev;
    sha256 = pkg.hash;
  };
in
  fetchPackage

