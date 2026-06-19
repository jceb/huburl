{
  description = "Tool for generating the URL of the current repository and path in a source control hub";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "i686-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        { pkgs, ... }:
        {
          packages.default = pkgs.callPackage ./default.nix { inherit pkgs; };
        };
    };
}
