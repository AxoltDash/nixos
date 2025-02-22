{ config, pkgs, ... }:

{
  # After 25.05 (Not fully completed and officially released yet)
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.roboto-mono
  ];
}
