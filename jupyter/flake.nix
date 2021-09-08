{
  description = "A very basic flake";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.jupyter.url = "github:tweag/jupyterWith";

  outputs = { self, nixpkgs, flake-utils, jupyter }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { system = system; };
          iPython = jupyter.lib.${system}.kernels.iPythonWith {
            name = "python";
            packages = p: with p; [ numpy ];
          };
          RustKernel = jupyter.lib.${system}.kernels.rustWith {
            # Name that will appear in the Jupyter interface
            name = "Rust-kernel";
            # Extra packages that can be used by the kernel and imported crates
            packages = with pkgs; [ rustc openssl pkgconfig ];
          };

          jupyterEnvironment =
            jupyter.lib.${system}.jupyterlabWith {
              kernels = [ iPython RustKernel ];
              # RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
            };
        in
        {
          packages.hello = pkgs.hello;
          defaultPackage = self.packages.${system}.hello;
          # devShell = (pkgs.mkShell {
          #   RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
          # }) // jupyterEnvironment.env;
          rp = pkgs.mkShell {
            RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
          };
          RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
          devShell = jupyterEnvironment.env;

        });
}
