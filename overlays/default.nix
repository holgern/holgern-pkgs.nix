{
  packages,
}:
final: _prev: {
  toktrail = packages.${final.stdenv.hostPlatform.system}.toktrail or null;
  codecrate = packages.${final.stdenv.hostPlatform.system}.codecrate or null;
}
