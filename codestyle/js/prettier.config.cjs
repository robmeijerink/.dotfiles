// This file is used by confirm.nvim plugin
module.exports = {
    semi: false,
    singleQuote: true,
    printWidth: 140,
    tabWidth: 4,
    trailingComma: 'all',
    bracketSpacing: true,
    bracketSameLine: true,
    arrowParens: 'always',
    singleAttributePerLine: true,
    vueIndentScriptAndStyle: false,
    htmlWhitespaceSensitivity: 'strict',
    // require.resolve searches for the plugin dynamically in my .dotfiles
    plugins: [require.resolve('prettier-plugin-tailwindcss')],
}
