-- add autoclose tags to html and jsx
return {
  "windwp/nvim-ts-autotag",
  event = "VeryLazy",
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false, -- Auto close on trailing </
  },
}
