{
    programs.nixvim.plugins.dap = {
        enable = true;
        extensions.dap-ui.enable = true;
    };


    programs.nixvim.keymaps = [
        {
            mode = "n";
            key = "<F5>";
            action = "function() require('dap').continue() end";
            lua = true;
        }
        {
            mode = "n";
            key = "<F10>";
            action = "function() require('dap').step_over() end";
            lua = true;
        }
        {
            mode = "n";
            key = "<F11>";
            action = "function() require('dap').step_into() end";
            lua = true;
        }
        {
            mode = "n";
            key = "<F12>";
            action = "function() require('dap').step_out() end";
            lua = true;
        }
        {
            mode = "n";
            key = "<Leader>db";
            action = "function() require('dap').toggle_breakpoint() end";
            lua = true;
        }
        {
            mode = "n";
            key = "<Leader>dB";
            action = "function() require('dap').set_breakpoint() end";
            lua = true;
        }
        {
            mode = "n";
            key = "<Leader>dr";
            action = "function() require('dap').repl_open() end";
            lua = true;
        }
        {
            mode = "n";
            key = "<Leader>dl";
            action = "function() require('dap').run_last() end";
            lua = true;
        }
        {
            mode = ["n" "v"];
            key = "<Leader>dh";
            action = "function() require('dap.ui.widgets').hover() end";
            lua = true;
        }
        {
            mode = ["n" "v"];
            key = "<Leader>dp";
            action = "function() require('dap.ui.widgets').preview() end";
            lua = true;
        }
        {
            mode = ["n" "v"];
            key = "<Leader>df";
            action = "function() require('dap.ui.widgets').centered_float(require('dap.ui.widgets').frames) end";
            lua = true;
        }
        {
            mode = ["n" "v"];
            key = "<Leader>ds";
            action = "function() require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes) end";
            lua = true;
        }
    ];
}
