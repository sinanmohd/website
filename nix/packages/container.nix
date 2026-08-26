{
  website-serve,
  dumb-init,
  lib,
  dockerTools,

  iSdebugBuild ? true,
  curl,
  jq,
  coreutils,
  gnused,
  gnugrep,
  findutils,
  neovim,
}:
dockerTools.buildLayeredImage {
  name = "sinanmohd/website";
  tag = "git";

  contents = [
    website-serve
  ]
  ++ lib.optional iSdebugBuild [
    curl
    jq
    coreutils
    gnused
    gnugrep
    findutils
    neovim
  ];

  config = {
    Cmd = [
      (lib.getExe dumb-init)
      (lib.getExe website-serve)
    ];
    ExposedPorts = {
      "8080/tcp" = { };
    };
  };
}
