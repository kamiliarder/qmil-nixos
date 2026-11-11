--@type LazySpec

return {
  "AstroNvim/astrolsp",
  opts = {
    config = {
      gopls = {
        settings = {
          gopls = {
            gofumpt = true,
          },
        },
      },
    },
  },
}
