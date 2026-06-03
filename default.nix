{pkgs, stdenv, ...}:
stdenv.mkDerivation {
  pname = "huburl";
  version = "1.0";

  # Point to the directory containing your script
  src = ./.;

  nativeBuildInputs = [ pkgs.nushell ];

  installPhase = ''
    mkdir -p $out/bin
    cp huburl $out/bin
    chmod +x $out/bin/huburl
  '';
}
