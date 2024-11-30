{ writeShellApplication, pamixer, pavucontrol, gnugrep }:
writeShellApplication {
  name = "polybar_pipewire_script";

  runtimeInputs = [ pamixer pavucontrol gnugrep ];

  text = builtins.readFile ./pipewire.sh;
}
