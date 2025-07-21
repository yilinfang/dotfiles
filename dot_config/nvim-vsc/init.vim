" NeoVim Configuration for VSCode integration
" Copyright (C) 2025 Yilin Fang

" Only load this configuration if running in VSCode
if !exists('g:vscode')
finish
endif

" Set leader and localleader keys
let g:mapleader = ' '
let g:maplocalleader = ' '

" Remove default key mappings
nunmap =
xunmap =
nunmap ==

" Custom key mappings for VSCode integration
nnoremap grf <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>
vnoremap grf <Cmd>call VSCodeNotify('editor.action.formatSelection')<CR>
nnoremap <leader>/ <Cmd>noh<CR>
