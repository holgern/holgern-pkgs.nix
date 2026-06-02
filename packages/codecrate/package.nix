{
  lib,
  flake,
  fetchPypi,
  python3Packages,
}:

python3Packages.buildPythonApplication rec {
  pname = "codecrate";
  version = "0.4.4";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-T1iP3TmRL9Z0aj1HPV/gJAKGCVoXhn16ebKgtEubxug=";
  };

  nativeBuildInputs = [
    python3Packages.setuptools
    python3Packages."setuptools-scm"
    python3Packages.wheel
  ];

  propagatedBuildInputs = [
    python3Packages.pathspec
  ];

  pythonImportsCheck = [ "codecrate" ];

  doInstallCheck = true;
  installCheckPhase = ''
    runHook preInstallCheck
    $out/bin/codecrate --help > /dev/null
    runHook postInstallCheck
  '';

  passthru.category = "Utilities";

  meta = with lib; {
    description = "Pack Python codebases into Markdown optimized for LLM context delivery";
    homepage = "https://github.com/holgern/codecrate";
    changelog = "https://github.com/holgern/codecrate/releases/tag/v${version}";
    license = licenses.mit;
    sourceProvenance = with sourceTypes; [ fromSource ];
    mainProgram = "codecrate";
    platforms = platforms.unix;
  };
}
