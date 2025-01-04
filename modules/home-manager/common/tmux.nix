{ pkgs, config, ... }:
{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    escapeTime = 0;
    mouse = true;
    terminal = "alacritty";

    plugins = with pkgs; [
      tmuxPlugins.cpu
      # See: https://github.com/tmux-plugins/tmux-resurrect/tree/master
      {
        plugin = tmuxPlugins.resurrect;
        # TODO: Set this up in neovim config if I want it.
        # extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      # See: https://github.com/tmux-plugins/tmux-continuum
      #{
      #  plugin = tmuxPlugins.continuum;
      #  extraConfig = ''
      #    set -g @continuum-restore 'on'
      #    set -g @continuum-save-interval '15'
      #  '';
      #}
    ];

    extraConfig = ''
      # Make color work properly in tmux.
      set-option -sa terminal-features ',alacritty:RGB'

      # Set fish as the default shell.
      set -g default-command ${pkgs.fish}/bin/fish
      set -g default-shell ${pkgs.fish}/bin/fish

      # change prefix to C-a
      set-option -g prefix C-a
      unbind-key C-b
      bind-key C-a send-prefix

      # hjkl pane traversal
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # start window index at 1
      set -g base-index 1

      # reorder windows with y
      bind y movew -r \; display-message "Windows reordered..."

      # mouse mode on
      set-option -g mouse on

      # vi copy mode bindings
      set -g status-keys vi
      set -g mode-keys vi

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'V' send -X select-line
      bind-key -T copy-mode-vi 'r' send -X rectangle-toggle
      bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel "${pkgs.xclip}/bin/xclip -in -selection clipboard"

      # split pane in same dir
      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      # styling
      set-option -g status-left "#{?window_zoomed_flag, 🔍 ,}"


      # sesh configuration - https://github.com/joshmedeski/sesh
      bind-key "T" run-shell "${pkgs.sesh}/bin/sesh connect \"$(
        ${pkgs.sesh}/bin/sesh list --icons | ${pkgs.fzf}/bin/fzf-tmux -p 55%,60% \
          --no-sort --ansi --border-label ' ${pkgs.sesh}/bin/sesh ' --prompt '⚡  ' \
          --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
          --bind 'tab:down,btab:up' \
          --bind 'ctrl-a:change-prompt(⚡  )+reload(${pkgs.sesh}/bin/sesh list --icons)' \
          --bind 'ctrl-t:change-prompt(🪟  )+reload(${pkgs.sesh}/bin/sesh list -t --icons)' \
          --bind 'ctrl-g:change-prompt(⚙️  )+reload(${pkgs.sesh}/bin/sesh list -c --icons)' \
          --bind 'ctrl-x:change-prompt(📁  )+reload(${pkgs.sesh}/bin/sesh list -z --icons)' \
          --bind 'ctrl-f:change-prompt(🔎  )+reload(${pkgs.fd}/bin/fd -H -d 2 -t d -E .Trash . ~)' \
          --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(${pkgs.sesh}/bin/sesh list --icons)' \
      )\""

      bind-key x kill-pane # skip "kill-pane 1? (y/n)" prompt
      set -g detach-on-destroy off  # don't exit from tmux when closing a session

      bind -N "switch to root session (via ${pkgs.sesh}/bin/sesh) " 9 run-shell "${pkgs.sesh}/bin/sesh connect --root \'$(pwd)\'"
    '';
  };

  # To use sesh outside of tmux for other purposes. Probably not needed.
  home.packages = [ pkgs.sesh ];

  home.file."${config.xdg.configHome}/sesh/sesh.toml".text = ''
    [[session]]
    name = "nix config files"
    path = "${config.home.homeDirectory}/my-nixos-config"
    startup_command = "nvim ."
    [[session]]
    name = "notes"
    path = "${config.home.homeDirectory}"
    startup_command = "ssh archives -t 'cd /var/lib/silverbullet/; nvim .; fish'"
  '';
}
