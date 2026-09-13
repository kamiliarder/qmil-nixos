if true then return {} end --NOTE: If you want to use this config just comment this line

---@type LazySpec
return {
  {
    "vyfor/cord.nvim",
    opts = {
      editor = {
        client = "1539518331986518099",
        icon = "https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExYWlscHVkcmN5M21yazhyczRxMGMybmlhZGhmMjdlaG9mNGhpM3ZqMyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/g2YnT74o9QuezBuYjL/giphy.gif",
      },
      display = {
        theme = "minecraft",
        flavor = "accent",
        layout = "editor",
        swap_icons = true,
      },
      idle = {
        details = "Taking a breakk~~~",
        timeout = 180000, -- 3 min /180k ms
      },
      timestamp = {
        shared = true,
      },
    },
  },
}
