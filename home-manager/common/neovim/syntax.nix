{
    programs.nixvim.plugins = {
        treesitter = {
            enable = true;

            nixvimInjections = true;

            # TODO: Figure out how to use these properly.
            # folding = true;
            # indent = true;
        };
    };
}
