# Includes all CLI software that I want installed on every one of my hosts.
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    distrobox
    claude-code
  ];
}
