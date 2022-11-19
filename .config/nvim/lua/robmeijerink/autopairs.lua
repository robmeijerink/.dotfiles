local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')
local cond = require('nvim-autopairs.conds')

npairs.setup({
  check_ts = true,
})

npairs.remove_rule('{')

npairs.add_rules({
    -- Don't insert a new line when using {}
    Rule("{", "}")
      :with_cr(cond.none())
  }
)

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))
