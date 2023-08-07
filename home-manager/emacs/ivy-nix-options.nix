{
  trivialBuild,
  fetchFromGitHub
}:
trivialBuild rec {
  pname = "ivy-nixos-options";
  version = "master-25-03-2021";
  src = fetchFromGitHub {
    owner = "travisbhartwell";
    repo = "nix-emacs";
    rev = "053a2d5110ce05b7f99bcc2ac4804b70cbe87916";
    hash = "sha256-2tOXMqpmd14ohzmrRoV5Urf0HlnRPV1EVHm/d8OBSGE=";
  };
  # elisp dependencies
  propagatedUserEnvPkgs = [
    nixos-options
    ivy
  ];
  buildInputs = propagatedUserEnvPkgs;
}
