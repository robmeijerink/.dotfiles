-- https://github.com/xdebug/vscode-php-debug/releases
local dap = require('dap')

dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = {"/opt/vscode-php-debug/out/phpDebug.js"},
}

dap.configurations.php = {
    {
        type = 'php',
        request = 'launch',
        name = 'Listen for xdebug',
        port = 9003,
        log = true,
        -- serverSourceRoot = '/srv/www/',
        -- localSourceRoot = '/home/www/VVV/www/',
    },
}
