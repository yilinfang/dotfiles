if vim.g.vscode then
    -- VSCode extension
else
    -- ordinary Neovim
    -- Load configuration from vimrc
    vim.cmd('source $HOME/.vimrc')
end
