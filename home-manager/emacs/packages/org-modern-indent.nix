{
  trivialBuild,
  fetchFromGitHub,
  org-modern,
}:
trivialBuild rec {
  pname = "org-modern-indent";
  version = "main-11-05-2023";
  src = fetchFromGitHub {
    owner = "jdtsmith";
    repo = "org-modern-indent";
    rev = "85f95d093d9b2d8fb9e4a705529eac4e2a888e87";
    hash = "sha256-rlDZfP9BhNhJNXjdrTjGDMWR37/Z6+9xUk8yvN/fdfg=";
  };
  # elisp dependencies
  propagatedUserEnvPkgs = [
    org-modern
  ];
  buildInputs = propagatedUserEnvPkgs;
}
