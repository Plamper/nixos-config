{ pkgs, lib, python3Packages, fetchPypi }:

python3Packages.buildPythonApplication rec {
  pname = "gnuhealth-client";
  version = "4.2.0";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-so6N8Zc1KsXCIN8cFW/GZ65HXQSq4tUM+yq1pKeGiik=";
  };
  
  nativeBuildInputs = [
    pkgs.gtk3
    pkgs.wrapGAppsHook
    pkgs.gobject-introspection
  ];

  propagatedBuildInputs = [
    # Specify dependencies
    pkgs.python3Packages.pycairo
    pkgs.python3Packages.python-dateutil
    pkgs.python3Packages.pygobject3
  ];

  doCheck = false;

}
