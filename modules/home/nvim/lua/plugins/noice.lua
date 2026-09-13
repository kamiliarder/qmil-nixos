if true then return {} end --WARN: Remove this line to use this file, we already have noice in the communities plugi

---@type LazySpec

return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
    },
  },
}
