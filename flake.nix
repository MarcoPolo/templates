{
  description = "A collection of flake templates";

  outputs = { self }: {

    templates = {

      trivial = {
        path = ./trivial;
        description = "A very basic flake";
      };

      typescript = {
        path = ./typescript;
        description = "Basic typescript environment. Run `setup`.";
      };

      simpleContainer = {
        path = ./simple-container;
        description = "A NixOS container running apache-httpd";
      };

      rust = {
        path = ./rust;
        description = "A Rust project template. Only includes a devShell setup.";
      };

      zig = {
        path = ./zig;
        description = "A Zig project template. Only includes a devShell setup.";
      };

      jupyter = {
        path = ./jupyter;
        description = "A jupyter project template.";
      };

    };

    defaultTemplate = self.templates.trivial;

  };
}
