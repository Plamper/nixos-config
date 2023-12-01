{ pkgs, ... }:
{
  config = {
    home.packages =
      let
        pythonWithLsp = pkgs.python3.withPackages
          (ps: with ps; [
            python-lsp-server
          ]
          ++ python-lsp-server.optional-dependencies.rope
          ++ python-lsp-server.optional-dependencies.mccabe
          ++ python-lsp-server.optional-dependencies.pycodestyle
          ++ python-lsp-server.optional-dependencies.pyflakes
          ++ python-lsp-server.optional-dependencies.yapf
          );
      in
      [
        pythonWithLsp
      ];
  };
}
