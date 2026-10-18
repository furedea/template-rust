{
  description = "";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { nixpkgs, nixpkgs-unstable, ... }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          cargo
          cargo-deny
          cargo-machete
          clippy
          commitlint
          deadnix
          # lefthook before 2.1.6 runs hooks under a pty, which agent sandboxes deny.
          nixpkgs-unstable.legacyPackages.${system}.lefthook
          ls-lint
          nixfmt
          rustc
          rustfmt
          statix
        ];
      };
    };
}
