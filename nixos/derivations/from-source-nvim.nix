{ pkgs, lib, ... }:

pkgs.stdenv.mkDerivation rec {
  name = "neovim";

  src = pkgs.fetchFromGitHub {
    owner = "neovim";
    repo = "neovim";
    rev = "v0.10.0"; 
    sha256 = "0p366agcv4lz1qs453i44f9h37r09r58qj8g2wpbj0g4f6js48ql";
  };

  buildInputs = [
    pkgs.cmake
    pkgs.libtool
    pkgs.pkg-config
    pkgs.automake
    pkgs.autoconf
    #pkgs.gnu-gettext
    pkgs.lua
    pkgs.python3
    pkgs.unzip
    pkgs.libuv
    #pkgs.lua-luv
  ];

  nativeBuildInputs = [ pkgs.makeWrapper ];

  doInstallCheck = false;

  installPhase = ''
    make install DESTDIR=$out
  '';

  meta = with lib; {
    description = "Neovim text editor - custom build from GitHub";
    #license = licenses.apache2;
    maintainers = with maintainers; [ ];
  };
}

