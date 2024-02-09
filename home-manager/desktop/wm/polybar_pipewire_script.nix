{ writeShellApplication, pamixer, pavucontrol }:
writeShellApplication {
  name = "polybar_pipewire_script";

  runtimeInputs = [ pamixer pavucontrol ];

  text = builtins.readFile ./pipewire.sh;
}
