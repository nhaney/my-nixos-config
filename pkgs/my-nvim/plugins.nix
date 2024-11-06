# Packages used in my neovim configuration that are not available on github.
{ fetchFromGitHub, vimUtils }:
{
  render-markdown-nvim = vimUtils.buildVimPlugin {
    name = "render-markdown-nvim";
    src = fetchFromGitHub {
      owner = "MeanderingProgrammer";
      repo = "render-markdown.nvim";
      rev = "v7.5.0";
      hash = "sha256-I2JOx+QMumoQmOWAHxxCFnT+mn3iycTrz62NLK0T+R0=";
    };
  };
}
