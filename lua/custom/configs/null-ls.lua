local augroup = vim.api.nvim_create_augroup("LspFormatting",{})
local null_ls = require("null-ls")
local opts = {
  sources = {
    -- null_ls.builtins.diagnostics.mypy,
    -- null_ls.builtins.formatting.prettierd,
        -- Enable Prettier for formatting JavaScript, TypeScript, and styled-components files
    -- null_ls.builtins.formatting.prettierd.with({
    --   extra_filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    -- }),
    -- Enable Stylelint for diagnostics (linting) only, without formatting
    null_ls.builtins.diagnostics.stylelint.with({
      extra_filetypes = { "javascript", "typescript", "typescriptreact" },
    }),
  },
  on_attach = function (client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function ()
          vim.lsp.buf.format({ bufnr = bufnr })
        end
      })
    end
  end
}

return opts;

