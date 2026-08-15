{ fetchurl
, python3Packages
}:

python3Packages.buildPythonPackage {
  pname = "moonshine-voice";
  version = "0.1.0";
  format = "wheel";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/fd/a3/e3c0156664e9505af7b23072c3e947cec3a7ee938764c70424051366c368/moonshine_voice-0.1.0-py3-none-manylinux_2_34_x86_64.whl";
    hash = "sha256-D4M960O61dz7TP0yV7bfg++avT8nvjGZYi/kGTLo2RY=";
  };

  dependencies = with python3Packages; [
    filelock
    google-crc32c
    numpy
    platformdirs
    requests
    sounddevice
    tqdm
  ];

  doCheck = false;
}
