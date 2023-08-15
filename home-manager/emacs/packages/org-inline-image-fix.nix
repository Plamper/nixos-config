{
  trivialBuild,
  fetchFromGitHub,
}:
trivialBuild rec {
  pname = "org-inline-image-fix";
  version = "main-14-08-2023";
  src = fetchFromGitHub {
    owner = "misohena";
    repo = "org-inline-image-fix";
    rev = "7b0a4ccb669efbdf11750261a65726e787a3c10b";
    hash = "sha256-D8cLlR/gpWvMBdL/KcMABeWwLH7KJsGkO3NipuMKFq8=";
  };
}
