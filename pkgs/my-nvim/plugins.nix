# Packages used in my neovim configuration that are not available on github.
{
  fetchFromGitHub,
  vimUtils,
}:
{
  # render-markdown-nvim = vimUtils.buildVimPlugin {
  #    name = "render-markdown-nvim";
  #    src = fetchFromGitHub {
  #      owner = "MeanderingProgrammer";
  #      repo = "render-markdown.nvim";
  #      rev = "v7.5.0";
  #      hash = "sha256-I2JOx+QMumoQmOWAHxxCFnT+mn3iycTrz62NLK0T+R0=";
  #    };
  #  };

  #   Not using this one right now.
  #   minuet-ai-nvim = vimUtils.buildVimPlugin {
  #     name = "minuet-ai-nvim";
  #     src = fetchFromGitHub {
  #       owner = "milanglacier";
  #       repo = "minuet-ai.nvim";
  #       rev = "97eb69061a358db54d7a7a7cfa239fcc5aedf852";
  #       hash = "sha256-ryiZGMr/OHX/YrHhSD1qxu52YDMHELVtUkb4dTHC1Jg=";
  #     };
  #   };
}
