-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`

-- Only enable servers whose binary is actually on PATH (i.e. provided by the
-- current direnv / nix dev-shell). Enabling every server from nvim-lspconfig
-- makes each one that is missing spam a "Spawning language server ... failed"
-- warning every time a matching filetype is opened.
local function discovered_servers()
  local names = {}
  for _, f in ipairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
    local name = vim.fn.fnamemodify(f, ":t:r")
    local ok, cfg = pcall(function() return vim.lsp.config[name] end)
    local cmd = ok and cfg and cfg.cmd or nil
    -- cmd can be a function (custom/RPC servers): can't inspect it, so keep it.
    if type(cmd) == "function" or (type(cmd) == "table" and vim.fn.executable(cmd[1]) == 1) then
      table.insert(names, name)
    end
  end
  return names
end

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  dependencies = { "neovim/nvim-lspconfig" },
  ---@type AstroLSPOpts
  opts = function()
    return {
      features = {
        codelens = true,
        inlay_hints = false,
        semantic_tokens = true,
      },
      formatting = {
        format_on_save = {
          enabled = true,
          allow_filetypes = {},
          ignore_filetypes = {},
        },
        disabled = {},
        timeout_ms = 1000,
      },
      config = {},
      handlers = {},
      autocmds = {
        lsp_codelens_refresh = {
          cond = "textDocument/codeLens",
          {
            event = { "InsertLeave", "BufEnter" },
            desc = "Refresh codelens (buffer)",
            callback = function(args)
              if require("astrolsp").config.features.codelens then vim.lsp.codelens.enable(true, { bufnr = args.buf }) end
            end,
          },
        },
      },
      mappings = {
        n = {
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
          ["<Leader>uY"] = {
            function() require("astrolsp.toggles").buffer_semantic_tokens() end,
            desc = "Toggle LSP semantic highlight (buffer)",
            cond = function(client)
              return client:supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
            end,
          },
        },
      },
      on_attach = function(client, bufnr) end,
      servers = discovered_servers(),
    }
  end,
}
