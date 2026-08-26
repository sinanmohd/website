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

    src = ../../.;
  };

  buildPhase = ''
    export ASTRO_TELEMETRY_DISABLED="1"
    export npm_config_nodedir=${nodejs}
    pnpm build
  '';

  installPhase = ''
    mkdir -p $out/share
    cp -r dist $out/share/www
  '';

  nativeBuildInputs = [
    pnpmConfigHook
    pnpm
    nodejs
  ];

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    fetcherVersion = 4;
    hash = "sha256-2cbN7SD1x3TQ4b3qXI/AS+apdCmMJd933bD4BaH0eAk=";
  };

  meta = {
    description = "Sinan's Blog.";
    homepage = "https://www.sinanmohd.com";
    platforms = lib.platforms.unix;
    license = lib.licenses.agpl3Plus;
    maintainers = with lib.maintainers; [ sinanmohd ];
  };
})
