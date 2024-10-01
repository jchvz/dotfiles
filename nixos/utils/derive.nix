{ pkgs, lib }:

{
  tar = { bname, pname, version, url, sha256, buildInputs }:
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
        homepage = url;
      };
    };

  rust = { owner, pname, version, sha256, buildInputs ? [ ], testsToSkip ? [ ] }:
    let
      repoPath = pkgs.fetchFromGitHub {
        inherit owner sha256;
        repo = pname;
        rev = version;
      };
    in
    pkgs.rustPlatform.buildRustPackage {
      inherit pname version buildInputs;
      
      src=repoPath;

      cargoLock.lockFile = "${repoPath}/Cargo.lock"; 

      configurePhase = ''
        echo "Automatically adding all buildInputs' bin directories to PATH"
        for input in ${toString buildInputs}; do
          if [ -d "$input/bin" ]; then
            export PATH=$input/bin:$PATH
            echo "Added $input/bin to PATH"
          else
            echo "No bin directory found in $input"
          fi
        done
      '';

      checkFlags = lib.concatMap (test: [ "--skip" test ]) testsToSkip;

      meta = with lib; {
        description = "Rust package ${pname} built from source on GitHub";
        homepage = "https://github.com/${owner}/${repo}";
        platforms = platforms.linux;
      };
    };
}

