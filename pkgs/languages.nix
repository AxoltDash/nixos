{ config, pkgs, lib, ... }:

{
  # PROGRAMS ====================================
  environment.systemPackages = with pkgs; [
    # HASKELL =--------------------------------=
    ghc
    # haskell-language-server
    # Libraries
    cabal-install
    # haskellPackages.minisat-solver
    
    # PYTHON =---------------------------------=
    python3
    
    # C =--------------------------------------=
    gcc
    
    # RUST =-----------------------------------=
    cargo
    rust-analyzer
    rustc
    
    # JAVASCRIPT =-----------------------------=
    nodejs
    
    # JAVA =-----------------------------------=
    jdk
    
    # GO =-------------------------------------=
    go
    
    # PHP =------------------------------------=
    php
    phpPackages.composer
    
    # JULIA =----------------------------------=
    julia

    # LUA =------------------------------------=
    luarocks # neovim plugins
    lua
    lua-language-server

  ];
  nixpkgs.config.allowUnfree = true;
}
