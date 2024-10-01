{ pkgs ? import <nixpkgs> {} }:

pkgs.buildGoModule rec {
  pname = "swag";
  version = "1.8.12";

  goPackagePath = "github.com/swaggo/swag";
  src = pkgs.fetchFromGitHub {
    owner = "swaggo";
    repo = "swag";
    rev = "v${version}";
    sha256 = "sha256-of-source"; # Replace with the correct sha256
  };

  vendorSha256 = null; # Optional, use if needed for vendored dependencies.

  meta = with pkgs.lib; {
    description = "Swag converts Go annotations to Swagger Documentation";
    homepage = "https://github.com/swaggo/swag";
    license = licenses.mit;
    maintainers = with maintainers; [ your-github-username ];
  };
}

