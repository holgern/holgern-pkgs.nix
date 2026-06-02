{
  lib,
  flake,
  fetchPypi,
  python3Packages,
}:

python3Packages.buildPythonApplication rec {
  pname = "toktrail";
  version = "0.2.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-4tEEmkm4iipSGY+8bDkBaozTlXYvI6/SYqsjtP/nqMw=";
  };

  nativeBuildInputs = [
    python3Packages.setuptools
    python3Packages."setuptools-scm"
    python3Packages.wheel
  ];

  propagatedBuildInputs = [
    python3Packages.typer
    python3Packages.click
    python3Packages.pyyaml
    python3Packages.tomli
    python3Packages.tzdata
  ];

  pythonImportsCheck = [ "toktrail" ];

  doInstallCheck = true;
  installCheckPhase = ''
    runHook preInstallCheck
    $out/bin/toktrail --help > /dev/null
    runHook postInstallCheck
  '';

  passthru.category = "Utilities";

  meta = with lib; {
    description = "Track harness token usage in local SQLite sessions";
    homepage = "https://github.com/holgern/toktrail";
    changelog = "https://github.com/holgern/toktrail/releases/tag/v${version}";
    license = licenses.mit;
    sourceProvenance = with sourceTypes; [ fromSource ];
    mainProgram = "toktrail";
    platforms = platforms.unix;
  };
}
