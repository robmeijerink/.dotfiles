-- https://github.com/xdebug/vscode-php-debug/releases
local dap = require('dap')

dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = { os.getenv("HOME") .. "/.vscode/extensions/xdebug.php-debug-1.32.1/out/phpDebug.js" }
}

dap.configurations.php = {
    {
        type = 'php',
        request = 'launch',
        name = 'Listen for xdebug',
        port = 9003,
        log = true,
        pathMappings = {
            ["/var/www/html"] = "${workspaceFolder}"
        },
        -- serverSourceRoot = '/srv/www/',
        -- localSourceRoot = '/home/www/VVV/www/',
    },
}
