{ pkgs }:
{
  download =
    { bname
    , bpath
    , version
    , url
    , sha256
    , buildInputs
    }:
    pkgs.stdenv.mkDerivation {
      inherit version;
      pname = bname;

      src = pkgs.fetchurl {
        inherit url sha256;
      };

      buildInputs = [ pkgs.libgcc ] ++ buildInputs; # jchvz: most things need libgcc
      nativeBuildInputs = [ pkgs.makeWrapper pkgs.autoPatchelfHook ];

      installPhase = ''
        mkdir -p $out/bin
        tar -xvf $src --strip-components=1
        mv ${bpath} $out/bin/${bname}
        chmod +x $out/bin/${bname}
      '';

      meta = {
        description = "${bname}: downloaded & patched pre-built binary from tar";
      };
    };
}
