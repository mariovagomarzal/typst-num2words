{
  pkgs,
  inputs,
  ...
}: {
  env.GREET = "Typst num2words development environment";

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
