{ writeShellApplication, gnused, pipewire, pamixer }:
writeShellApplication {
  name = "polybar_pipewire_script";

  runtimeInputs = [ gnused pipewire pamixer ];

  text = builtins.readFile ./pipewire.sh;
}
