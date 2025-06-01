{ lib, stdenv, fetchurl, zstd, protonCachyosVersions }:

stdenv.mkDerivation {
  name = "proton-cachyos";
  version = "${protonCachyosVersions.base}-${protonCachyosVersions.release}";

  src = fetchurl {
    url =
      "https://mirror.cachyos.org/repo/x86_64_v3/cachyos-v3/proton-cachyos-1:${protonCachyosVersions.base}.${protonCachyosVersions.release}-2-x86_64_v3.pkg.tar.zst";
    inherit (protonCachyosVersions) sha256;
  };

  nativeBuildInputs = [ zstd ];

  installPhase = ''
    tar -I zstd -xf $src
    mkdir -p $out/share/steam/compatibilitytools.d
    mv usr/share/steam/compatibilitytools.d/proton-cachyos $out/share/steam/compatibilitytools.d/
  '';

  meta = with lib; {
    description =
      "CachyOS Proton build with additional patches and optimizations";
    homepage = "https://github.com/CachyOS/proton-cachyos";
    license = licenses.bsd3;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ kimjongbing ];
  };
}
