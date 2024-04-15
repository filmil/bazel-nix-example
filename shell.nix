# This file seems to be required for the nix subsystem to work.

{ pkgs ? import ./nixpkgs.nix { } }:

  pkgs.mkShellNoCC {
    nativeBuildInputs = [ 
      # This seems required, else you get bizarre errors.
      pkgs.nix

      # This instructs nix to import the package `hello`, which contains
      # the GNU Hello binary.
      pkgs.hello 
    ]; 
  }
