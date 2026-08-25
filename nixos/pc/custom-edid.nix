{ pkgs, ... }:
let
  edid4k120hdr = pkgs.runCommand "edid-4k120-hdr" { } ''
    mkdir -p $out/lib/firmware/edid
    base64 -d > "$out/lib/firmware/edid/edid-4k120hdr.bin" <<'EOF'
    AP///////wAF480MAAAAAAMbAQOAPiJ46h7Frk80sSYOUFQvzwDRz7MAqcCVAIEAgcABAQEBAjqAGHE4LUBYLDUA4A4RAAAaAAAA/AAyOEU4NTAKICAgICAgAAAAEAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAUACA1BwUHZhYF9eXb8FHxQgBBMSAwE1DxcFfxdtFQdQVxcAPRdQXxcAZxcAg08AAGcDDAAQADhEbdhdxAF4AAMAAAADAADjBYOB4wYNAeIPcQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgw==
    EOF
  '';
in
{
  hardware.display.edid.packages = [
    edid4k120hdr
  ];

  hardware.display.outputs."DP-2" = {
    edid = "edid-4k120hdr.bin";
    mode = "3840x2160@120e";
  };
}
