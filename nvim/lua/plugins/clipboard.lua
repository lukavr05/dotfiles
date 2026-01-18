return {
  {
    "ojroques/nvim-osc52",
    config = function()
      require("osc52").setup({
        max_length = 0, -- Maximum length of selection (0 = no limit)
        trim = false,   -- Trim whitespace before copying
        silent = false, -- Disable messages on successful copy
      })
    end,
  },
}