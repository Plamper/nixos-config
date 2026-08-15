{ lib
, stdenv
, fetchFromGitHub

, meson
, ninja
, pkg-config
, gettext
, desktop-file-utils
, makeWrapper
, wrapGAppsHook4
, python3Packages
, ibus
, libadwaita
, gtk4
, glib
, gsettings-desktop-schemas

, gst_all_1
, whisper-cpp-vulkan
, vulkan-loader
, callPackage
, pywhispercpp ? callPackage ../pywhispercpp { }
, moonshineVoice ? callPackage ../moonshine-voice { }
}:

let
  inherit (python3Packages) python;

  pythonEnv = python.withPackages (ps: with ps; [
    babel
    dbus-python
    pygobject3
    numpy
    pywhispercpp
    moonshineVoice
    onnx-asr
    huggingface-hub
  ]);
in
stdenv.mkDerivation {
  pname = "ibus-speech-to-text";
  version = "unstable-2026-08-06";

  src = fetchFromGitHub {
    owner = "Manish7093";
    repo = "IBus-Speech-To-Text";
    rev = "8ba83463e67a5b1cd1a845317a169c5c73ab4794";
    hash = "sha256-IL//sVkz6Kr0FYqKcc2D+vrC2A1o5pUJyNS7DMbZS/s=";
  };

  # Let the IBus engine register before synchronously loading Whisper.
  postPatch = ''
    sed -i 's/^        self._set_model()$/        GLib.idle_add(self._set_model)/' engine/sttgstwhisper.py
    sed -i '/^        stt_gst_factory_default()$/d' engine/main.py
    sed -i '/^        # Start a loop$/i\\        stt_gst_factory_default()' engine/main.py

    python - <<'PY'
import re
from pathlib import Path

path = Path("engine/sttengine.py")
text = path.read_text()
text = re.sub(
    r'(?P<field>label|tooltip)=_\("(?P<value>[^"]*)"\)',
    r'\g<field>=IBus.Text.new_from_string(_("\g<value>"))',
    text,
)
text = text.replace("type=IBus.PropType", "prop_type=IBus.PropType")
text = text.replace("IBus.Text(_(", "IBus.Text.new_from_string(_(")
text = text.replace("icon=None", "icon=\"\"")
path.write_text(text)

PY
  '';

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    gettext
    desktop-file-utils
    makeWrapper
    wrapGAppsHook4
    pythonEnv
  ];

  buildInputs = [
    ibus
    libadwaita
    gtk4
    glib
    gsettings-desktop-schemas
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-libav
    whisper-cpp-vulkan
    vulkan-loader
  ];

  postFixup = ''
    for program in $out/libexec/ibus-engine-stt $out/libexec/ibus-setup-stt; do
      wrapProgram "$program" \
        --set GGML_BACKEND_PATH "${whisper-cpp-vulkan}/lib/libggml-vulkan.so" \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ whisper-cpp-vulkan vulkan-loader ]}"
    done

    substituteInPlace $out/share/ibus/component/stt.xml \
      --replace-fail '</exec>' '</exec>
  <setup>@out@/libexec/ibus-setup-stt</setup>' \
      --subst-var-by out "$out"
  '';

  passthru = { inherit pywhispercpp; };

  meta = {
    isIbusEngine = true;
    description = "Speech-to-text IBus input method using Vosk, Whisper, and Moonshine";
    homepage = "https://github.com/Manish7093/IBus-Speech-To-Text";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
    maintainers = [ ];
  };
}
