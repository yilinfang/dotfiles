-- Personal Neovim Configuration
-- General settings

if vim.g.vscode then
    -- VSCode extension only
else
    -- Ordinary Neovim only
    
    -- Load settings from ~/.vimrc
    vim.cmd('source ~/.vimrc')
end
