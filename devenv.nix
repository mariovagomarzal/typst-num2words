{pkgs, ...}: {
  env.GREET = "Typst num2words development environment";

  languages.typst.enable = true;

  packages = with pkgs; [
    just
    git
    prek
    alejandra
  ];

  enterShell = ''
    echo $GREET
    prek install -t pre-commit -t commit-msg
  '';
}
