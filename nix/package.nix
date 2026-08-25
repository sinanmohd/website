{
  lib,
  stdenv,
  nodejs,
  pnpm,
  version,
  pnpmConfigHook,
  fetchPnpmDeps,
}:

stdenv.mkDerivation (finalAttrs: {
  inherit version;
  pname = "website";

  src = lib.cleanSourceWith {
    filter =
      name: type:
      lib.cleanSourceFilter name type
      && !(builtins.elem (baseNameOf name) [
        "nix"
        "flake.nix"
        "flake.lock"
      ]);

    src = ../.;
  };

  buildPhase = ''
    export NODE_OPTIONS="--max_old_space_size=16384"
    export NUXT_TELEMETRY_DISABLED=1
    export npm_config_nodedir=${nodejs}

    pnpm exec nuxt generate
  '';

  installPhase = ''
    mkdir -p $out/share
    cp -r .output/public $out/share/www
  '';

  nativeBuildInputs = [
    pnpmConfigHook
    pnpm
    nodejs
  ];

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    fetcherVersion = 4;
    hash = "sha256-DiT2/Mnj2Cwpdk2dd2JddJlgR6wNU8kSKbvu+FX+LPk=";
  };

  meta = {
    description = "Sinan's website.";
    homepage = "https://www.sinanmohd.com";
    platforms = lib.platforms.unix;
    license = lib.licenses.agpl3Plus;
    maintainers = with lib.maintainers; [ sinanmohd ];
  };
})
