{
    programs.nixvim = {
        opts = {
            number = true;
            relativenumber = true;

            swapfile = false;
            undofile = true;

            # Ignore casing in search unless uppercase character appears.
            ignorecase = true;
            smartcase = true;

            fileencoding = "utf-8";

            # Tab options. Default to 4 spaces.
            autoindent = true;
            expandtab = true;
            tabstop = 4;
            shiftwidth = 4;
        };

        clipboard = {
            register = "unnamedplus";
        };
    };
}
