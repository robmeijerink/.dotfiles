require('neotest').setup({
    adapters = {
        -- require('neotest-phpunit')({
        --     phpunit_cmd = function()
        --         return "vendor/bin/phpunit"
        --     end
        -- }),
        require('neotest-pest')({
            pest_cmd = function()
              return "vendor/bin/pest"
            end
        }),
    }
})
