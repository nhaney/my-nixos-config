{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    escapeTime = 0;
    mouse = true;
    terminal = "screen-256color";

    plugins = with pkgs; [
      tmuxPlugins.cpu
      # See: https://github.com/tmux-plugins/tmux-resurrect/tree/master
      {
        plugin = tmuxPlugins.resurrect;
        # TODO: Set this up in neovim config if I want it.
        # extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      # See: https://github.com/tmux-plugins/tmux-continuum
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
        '';
      }
    ];

    extraConfig = ''
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
    '';
  };
}
