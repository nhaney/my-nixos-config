local M = {}

function M.setup()
  local max_filesize = 100 * 1024 -- 100 KB

  local function should_disable(buf)
    local ok, stats = pcall(
      vim.loop.fs_stat,
      vim.api.nvim_buf_get_name(buf)
    )
    return ok and stats and stats.size > max_filesize
  end

  -- Enable Tree-sitter highlighting + indent on buffer attach as long as file isn't too big.
  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      local buf = args.buf

      if should_disable(buf) then
        return
      end

      -- Start Tree-sitter highlighting
      -- Language is inferred automatically from FileType
      pcall(vim.treesitter.start, buf)

      -- Disable regex-based :syntax highlighting
      vim.bo[buf].syntax = "off"

      -- Enable Tree-sitter indentation except for html
      if vim.bo[buf].filetype ~= "html" then
        vim.bo[buf].indentexpr = "v:lua.vim.treesitter.indent()"
      end
    end,
  })
end

return M

