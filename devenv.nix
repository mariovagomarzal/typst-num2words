{
  pkgs,
  inputs,
  ...
}: {
  env.GREET = "Typst num2words development environment";

  # Tytanic publishes its flake outputs to this cache, so it doesn't have to be
  # built from source. Its own `nixConfig` is ignored when it's used as an input.
  cachix.pull = ["tytanic"];

  overlays = [
    (final: prev: {
      # Add Tytanic to Nixpkgs.
      tytanic = inputs.tytanic.packages.${final.system}.default;
    })
  ];

  languages.typst = {
    enable = true;
    fontPaths = [
      "${pkgs.gyre-fonts}"
      "${pkgs.liberation_ttf}"
    ];
  };

  env = {
    TYPST_ROOT = ".";
    TYPST_IGNORE_SYSTEM_FONTS = "true";
  };

  packages = with pkgs; [
    just
    git
    prek
    alejandra
    tytanic
  ];

  enterShell = ''
    echo $GREET
    prek install -t pre-commit -t commit-msg
  '';
}
