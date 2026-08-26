{
  pkgs,
  website,
}:

pkgs.writeShellApplication {
  name = "website-serve";
  runtimeInputs = with pkgs; [ caddy ];
  text = ''
    caddy file-server --listen :8008 --root ${website}/share/www
  '';
}
