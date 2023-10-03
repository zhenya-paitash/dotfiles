local wk = require("which-key")

wk.register({
  a = { "Visual select all file" },
  f = {
    name = "Find",
    f = { "Find File" },
    b = { "Find Buffer" },
    h = { "Find Help" },
    w = { "Find Text" },
    g = { "Find live_grep" },
    o = { "Find TODOs" },
    n = { "Find Notification" },
  },
  e = { "File Manager" },
  o = { "Git status" },
  x = { "Close Buffer" },
  X = { "Close other buffers" },
  t = {
    name = "Trouble",
    t = { "Open" },
    d = { "Open document_diagnostics" },
    w = { "Open workspace_diagnostics" },
    q = { "Open quickfix" },
    l = { "Open loclist" },
    r = { "Open lsp_references" },
    o = { "Open TODO" },
    ["["] = { "Jump to previous trouble" },
    ["]"] = { "Jump to next trouble" },
  },
  g = {
    name = "Git",
    b = "Branches",
    c = "Commits",
    s = "Status"
  },
  c = {
    name = "Comment",
  },
  l = {
    name = "LSP",
    d = "Diagnostic",
    D = "Hover diagnostic",
    f = "Format",
    r = "Rename",
    a = "Action",
    s = "Symbol"
  },
  h = { "No highlight" },
  w = { name = "Save current file" },

  ["<leader>"] = { "Find File" },
  ["*"] = { "Find Telescope grep_string" },
}, { prefix = "<leader>" })
