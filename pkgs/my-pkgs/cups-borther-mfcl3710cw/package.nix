{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  autoPatchelfHook,
  makeWrapper,
  perl,
  gnused,
  ghostscript,
  file,
  coreutils,
  gnugrep,
  which,
}:
let
  version = "1.0.2-0";
  runtimeDeps = [
    ghostscript
    file
    gnused
    gnugrep
    coreutils
    which
  ];
in
stdenv.mkDerivation {
  pname = "cups-brother-mfcl3710cw";
  inherit version;

  nativeBuildInputs = [
    dpkg
    makeWrapper
    autoPatchelfHook
  ];
  buildInputs = [ perl ];

  dontUnpack = true;

  src = fetchurl {
    url = "https://download.brother.com/welcome/dlf103930/mfcl3710cwpdrv-1.0.2-0.i386.deb";
    hash = "sha256-vSE7fSzix3yXXyn12dUeSjo9AwDNMs8oXS9LIbjX/ho=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    dpkg-deb -x $src $out

    # Ajusta rutas y nombres en el filtro
    substituteInPlace $out/opt/brother/Printers/mfcl3710cw/lpd/brmfcl3710cwfilter \
      --replace-fail /opt "$out/opt" \
      --replace-fail "my \$PRINTERMODEL =" "my \$PRINTERMODEL = \"mfcl3710cw\"; #"

    # Asegura dependencias en el PATH de los ejecutables
    find "$out" -executable -and -type f | while read file; do
      wrapProgram "$file" --prefix PATH : "${lib.makeBinPath runtimeDeps}"
    done

    # Enlaza filtro y PPD para CUPS
    mkdir -p $out/lib/cups/filter $out/share/cups/model

    ln -s \
      $out/opt/brother/Printers/mfcl3710cw/lpd/brmfcl3710cwfilter \
      $out/lib/cups/filter/brother_lpdwrapper_mfcl3710cw

    ln -s \
      $out/opt/brother/Printers/mfcl3710cw/cupswrapper/brother_mfcl3710cw_printer_en.ppd \
      $out/share/cups/model/

    runHook postInstall
  '';

  meta = {
    homepage = "http://www.brother.com/";
    description = "Brother MFC-L3710CW printer driver";
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" "i686-linux" ];
    maintainers = [ ];
  };
}
