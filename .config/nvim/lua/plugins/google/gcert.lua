-- https://g3doc.corp.google.com/experimental/users/fentanes/gcert.nvim/README.md?cl=head
return {
  url = "sso://user/fentanes/gcert.nvim",
  dependencies = {
    "rcarriga/nvim-notify", -- Optional
  },
  event = "VeryLazy",
  opts = {
    check_gcert_interval_ms = 10000,
    autorun_gcert = false,
    gcert_executable = "gcert",
    split_size = 12,
    show_notifications = true,
    use_nvim_notify = true,
  },
}
