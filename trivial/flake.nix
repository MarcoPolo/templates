{
  description = "A very basic flake";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { system = system; };
      in
      {
        packages.hello = pkgs.hello;
        defaultPackage = self.packages.${system}.hello;
        devShell = pkgs.mkShell {
          buildInputs = [ pkgs.hello ];
        };
      });
}
