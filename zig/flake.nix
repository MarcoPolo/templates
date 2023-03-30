{
  description = "A Zig Dev flake";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.zig-overlay = {
    url = "github:mitchellh/zig-overlay";
    inputs = {
      flake-utils.follows = "flake-utils";
    };
  };
  inputs.zls = {
    url = "github:zigtools/zls";
    inputs = {
      zig-overlay.follows = "zig-overlay";
      flake-utils.follows = "flake-utils";
    };
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, zls, zig-overlay, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { system = system; };
        zig = zig-overlay.packages.${system}."master";
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            zls.packages.${system}.default
            zig
          ];
        };
      });
}
