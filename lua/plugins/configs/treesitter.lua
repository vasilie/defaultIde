local options = {
  ensure_installed = { "lua", "vim", "vimdoc",  "javascript", "typescript", "css", "html"  },

  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = false,
  },

  indent = { enable = true },
  -- Disable Treesitter indentation for .styles.js files
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "javascript", -- Applies to JavaScript files
  callback = function()
    local filename = vim.fn.expand("%:t") -- Get the current filename
    if filename:match("%.styles%.js$") then
      vim.bo.indentexpr = "" -- Disable Treesitter indent expression
    end
  end,
})

return options

