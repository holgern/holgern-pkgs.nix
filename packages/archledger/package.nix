{
  lib,
  flake,
  fetchPypi,
  python3Packages,
}:

python3Packages.buildPythonApplication rec {
  pname = "archledger";
  version = "0.2.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-mzvDWv/1tzothNuBrXqlkgyTYWnkBmzpRyEEdjOZQK4=";
  };

  nativeBuildInputs = [
    python3Packages.setuptools
    python3Packages."setuptools-scm"
    python3Packages.wheel
  ];

  propagatedBuildInputs = [
    python3Packages.typer
    python3Packages.pyyaml
    python3Packages."jinja2"
    python3Packages.tomli
  ];

  pythonImportsCheck = [ "archledger" ];

  doInstallCheck = true;
  installCheckPhase = ''
    runHook preInstallCheck
    $out/bin/archledger --help > /dev/null
    runHook postInstallCheck
  '';

  passthru.category = "Utilities";

  meta = with lib; {
    description = "Source-first arc42 architecture documentation from Markdown and AsciiDoc records";
    homepage = "https://github.com/holgern/archledger";
    changelog = "https://github.com/holgern/archledger/releases/tag/v${version}";
    license = licenses.asl20;
    sourceProvenance = with sourceTypes; [ fromSource ];
    mainProgram = "archledger";
    platforms = platforms.unix;
  };
}
