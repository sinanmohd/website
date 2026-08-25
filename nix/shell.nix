{
  mkShell,
  website,
  nixfmt,
  typescript-language-server,
  vue-language-server,
  tailwindcss-language-server,
  gopls,
  sqlc,
  air,
  nodejs,
}:

mkShell {
  inputsFrom = [
    website
  ];

  buildInputs = [
    gopls
    sqlc
    air

    nixfmt

    vue-language-server
    typescript-language-server
    tailwindcss-language-server
  ];

  shellHook = ''
    export PS1="\033[0;31m[website]\033[0m $PS1"
    export NODE_ENV="development"

    export npm_config_nodedir=${nodejs}
    pnpm config set store-dir ~/.local/share/pnpm
  '';
}
