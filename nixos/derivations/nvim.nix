{ pkgs, lib, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "neovim";
  version = "0.10.1"; # Replace with the version you want

  src = pkgs.fetchurl {
    url = "https://github.com/neovim/neovim/releases/download/v${version}/nvim-linux64.tar.gz";
    sha256 = "14wp3y7p049zvs9h5k43dsix63hbnham5apq0bwq6q3zl40xwrs8";
  };

  nativeBuildInputs = [
    pkgs.makeWrapper
    pkgs.autoPatchelfHook
  ];

  # .so needed by nvim, used by autoPatchelfHook
  buildInputs = [
    pkgs.libgcc
  ];

  installPhase = ''
    mkdir -p $out/bin $out/share
    tar -xvf $src --strip-components=1 -C $out
    chmod +x $out/bin/nvim
    #mkdir -p $out
    #tar -xvf $src -C $out
    #chmod +x $out/nvim-linux64/bin/nvim
  '';

  meta = with lib; {
    description = "Neovim text editor - prebuilt binary from GitHub";
    #license = lib.licenses.apache2; # Correctly reference licenses
    maintainers = [ ]; # Empty maintainers for now
  };
}

