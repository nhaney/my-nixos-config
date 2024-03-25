{ pkgs, ... }:
{
    programs.tmux = {
        enable = true;
        shortcut = "a";
        extraConfig = ''
set -g default-terminal "screen-256color"

set-option -sa terminal-overrides ',xterm-256color:RGB'

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

# allows for faster repitition
set -s escape-time 0

# reload config with r
bind r source-file ~/.tmux.conf \; display-message "Config reloaded..."

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
bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel "xclip -in -selection clipboard"

# split pane in same dir
bind c new-window -c "#{pane_current_path}"
bind '"' split-window -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"

# styling
set-option -g status-left "#{?window_zoomed_flag, 🔍 ,}"
        '';
    };
}
