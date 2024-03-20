local npairs = require "nvim-autopairs"
local Rule = require "nvim-autopairs.rule"

local latex = { "tex", "latex" }
local rules = {
    Rule("\\(", "  \\)", latex):set_end_pair_length(3),
    Rule("\\[", "  \\]", latex):set_end_pair_length(3),
    Rule("\\{", "  \\}", latex):set_end_pair_length(3),
    Rule("\\left(", "  \\right)", latex):set_end_pair_length(8),
    Rule("\\left[", "  \\right]", latex):set_end_pair_length(8),
    Rule("\\left\\{", "  \\right\\}", latex):set_end_pair_length(9),
    Rule("$", "$", "markdown"),
}

for _, rule in pairs(rules) do
    npairs.add_rule(rule)
end
