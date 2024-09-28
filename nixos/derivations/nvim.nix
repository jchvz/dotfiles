{ pkgs, ... }:

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
    mkdir -p $out/bin
    tar -xvf $src --strip-components=1 -C $out
    chmod +x $out/bin/nvim
  '';

  meta = {
    description = "${pname}: patchelfed pre-built binary from tar";
  };
}

