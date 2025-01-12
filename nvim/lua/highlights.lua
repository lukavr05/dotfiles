local M = {}

M.override = {
    Comment = { italic = true, fg = "#466185" },
    ["@comment"] = { link = "Comment" },
    ["@comment.rust"] = { link = "Comment" },
    ["@comment.python"] = { link = "Comment" },
    ["@comment.java"] = { link = "Comment" },
    ["@comment.go"] = { link = "Comment" },
    ["@comment.markdown"] = { link = "Comment" },
    ["@comment.txt"] = { link = "Comment" },
    ["@comment.css"] = { link = "Comment" },

    -- Types
    Type = {italic = true, fg = "#275aab"},
    ["@type"] = { link = "Type" },
    ["@type.rust"] = { link = "Type" },
    ["@type.python"] = { link = "Type" },
    ["@type.java"] = { link = "Type" },
    ["@type.go"] = { link = "Type" },

    -- Functions
    Function = { fg = "#35aef0", bold = true },
    ["@function"] = { link = "Function" },

    -- Keywords
    -- Delimiter for miniIndent lines
    Delimiter = { fg = "#6bcde8" },
    ["@delimiter"] = { link = "Delimiter" },

    Keyword = { fg = "#6bcde8"},
    ["@keyword"] = { link = "Keyword" },

    -- Strings
    ["@string"] = { fg = "#36eb75" },

    ["@boolean"] = { bold = true, fg = "#10e0cf"},

    ["@statement"] = { fg = "#10e0cf" },
    ["@conditional"] = { fg = "#10e0cf"},

    -- tablines
    ["TbFill"] = { bg = "#191724" },
    ["TbBufOff"] = { bg = "#191724" },

    NvDashAscii = { fg = "#36eb75"},
    NvDashButtons = { fg = "#466185" },
}
M.add = {
    NvDashFooter = { fg = "#486fa3"},
    SnacksDashboardNormal = { fg = "#466185" },
    SnacksDashboardHeader = { link = "SnacksDashboardTitle" },
    SnacksDashboardTitle = { bold = true, fg = "#275aab" },
    SnacksDashboardFooter = { italic = true },
    SnacksDashboardDesc = { italic = true },
    SnacksDashboardIcon = { fg = "#275aab" },
    SnacksDashboardDir = { italic = true },
    SnacksDashboardFile = { fg = "#35aef0", bold = true }
}
return M
