{ pkgs }:
{
  download =
    { bname
    , pname
    , version
    , url
    , sha256
    , buildInputs
    }:
    pkgs.stdenv.mkDerivation {
      inherit pname version;

      src = pkgs.fetchurl {
        inherit url sha256;
      };

      buildInputs = buildInputs;
      nativeBuildInputs = [ pkgs.makeWrapper pkgs.autoPatchelfHook ];

      installPhase = ''
        mkdir -p $out/bin
        tar -xvf $src --strip-components=1 -C $out
        chmod +x $out/bin/${bname}
      '';

      meta = {
        description = "${pname}: downloaded & patched pre-built binary from tar";
      };
    };
}
