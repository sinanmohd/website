{
  inputs.nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      lib = nixpkgs.lib;

      forSystem =
        f: system:
        f {
          inherit system;
          pkgs = import nixpkgs { inherit system; };
        };
      supportedSystems = lib.platforms.unix;
      forAllSystems = f: lib.genAttrs supportedSystems (forSystem f);

      version =
        if self ? shortRev then
          self.shortRev
        else if self ? dirtyShortRev then
          self.dirtyShortRev
        else
          "not-a-gitrepo";
    in
    {
      packages = forAllSystems (
        { system, pkgs }:
        {
          website = pkgs.callPackage ./nix/package.nix {
            inherit version;
          };
          default = self.packages.${system}.website;
        }
      );

      devShells = forAllSystems (
        { system, pkgs }:
        {
          website = pkgs.callPackage ./nix/shell.nix {
            website = self.packages.${system}.website;
          };
          default = self.devShells.${system}.website;
        }
      );
    };
}
