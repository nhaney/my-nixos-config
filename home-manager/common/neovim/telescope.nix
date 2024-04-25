{ pkgs, ...}:
{
    home.packages = with pkgs; [
        ripgrep
    ];

    programs.nixvim = {
        plugins.telescope = {
            enable = true;

            keymaps = {
                "<leader>ff" = "find_files";
                "<leader>fg" = "live_grep";
                "<leader>b" = "buffers";
                "<leader>fh" = "help_tags";
                "<leader>fd" = "diagnostics";

                "<C-p>" = "git_files";
                "<leader>p" = "oldfiles";
                "<C-f>" = "live_grep";
            };

            keymapsSilent = true;

            defaults = {
                file_ignore_patterns = [
                    "^.git/"
                    "^.mypy_cache/"
                    "^__pycache__/"
                    "^output/"
                    "^data/"
                    "%.ipynb"
                ];
                set_env.COLORTERM = "truecolor";
            };
        };
    };
}
