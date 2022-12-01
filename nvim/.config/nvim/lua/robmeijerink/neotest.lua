require('neotest').setup({
    adapters = {
        require('neotest-phpunit')({
            phpunit_cmd = function()
                return "vendor/bin/phpunit"
            end
        })
    }
})