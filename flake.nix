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

    };

    defaultTemplate = self.templates.trivial;

  };
}
