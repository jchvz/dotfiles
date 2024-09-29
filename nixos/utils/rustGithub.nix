{ pkgs, lib }:

{ owner, pname, version, sha256, buildInputs ? [ ], testsToSkip ? [ ] }:

pkgs.rustPlatform.buildRustPackage rec {
  inherit pname version buildInputs;

  # TODO: combine owner and pname
  # splitRepo = builtins.split "/" repo

  src = pkgs.fetchFromGitHub {
    inherit owner sha256;
    repo = pname;
    rev = version;
  };

  # TODO: I guess it's possible someone might not have Cargo.lock at the root
  # of their repository one day...
  cargoLock.lockFile = src + "/Cargo.lock";

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

  # https://github.com/NixOS/nixpkgs/blob/e74c9af04cfd2c32773e34e6d0ecdd36855e0ba5/pkgs/build-support/rust/hooks/cargo-check-hook.sh
  # This is the check hook of `buildRustPackage`
  # it allows us to configure the behavior of `cargo test`, in this case, by 
  # skipping tests
  checkFlags = lib.concatMap (test: [ "--skip" test ]) testsToSkip;

  # TODO: parse Cargo.toml for description, homepage, license, etc
  meta = with lib;{
    description = "Rust package ${pname} built from source on GitHub";
    homepage = "https://github.com/${owner}/${repo}";
    platforms = platforms.linux;
  };
}

