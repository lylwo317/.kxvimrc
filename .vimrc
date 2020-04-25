" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"  _  ____  __  __     _____ __  __ 
" | |/ /\ \/ /  \ \   / /_ _|  \/  |
" | ' /  \  /____\ \ / / | || |\/| |
" | . \  /  \_____\ V /  | || |  | |
" |_|\_\/_/\_\     \_/  |___|_|  |_|
"
"   This is the personal .vimrc file of Kevin Xie. 
"
"   Copyright 2020 Kevin Xie
"
"   Licensed under the Apache License, Version 2.0 (the "License");
"   you may not use this file except in compliance with the License.
"   You may obtain a copy of the License at
"
"       http://www.apache.org/licenses/LICENSE-2.0
"
"   Unless required by applicable law or agreed to in writing, software
"   distributed under the License is distributed on an "AS IS" BASIS,
"   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
"   See the License for the specific language governing permissions and
"   limitations under the License.
" }

" Initialize directories {
function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    let common_dir = parent . '/.' . prefix
    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()

set backup                  " Backups are nice ...
if has('persistent_undo')
    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif
" }

" Environment {

    " Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win32') || has('win64'))
        endfunction
    " }

    " Basics {
        set nocompatible        " Must be first line
        if !WINDOWS()
            set shell=/bin/sh
        endif
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if WINDOWS()
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }
    
    " Arrow Key Fix {
        " https://github.com/spf13/spf13-vim/issues/780
        if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
            inoremap <silent> <C-[>OC <RIGHT>
        endif
    " }

" }

" Plugin {
    " if empty(glob('~/.vim/autoload/plug.vim'))
    "     silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    "     autocmd VimEnter * PlugInstall | source $MYVIMRC
    " endif

    call plug#begin('~/.vim/plugged')
    " 多光标编辑
    Plug 'terryma/vim-multiple-cursors'
    " 定义插件，默认用法，和 Vundle 的语法差不多
    Plug 'junegunn/vim-easy-align'
    Plug 'skywind3000/quickmenu.vim'

    " 延迟按需加载，使用到命令的时候再加载或者打开对应文件类型才加载
    " Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    " Plug 'scrooloose/nerdtree'
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

    " 确定插件仓库中的分支或者 tag
    Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
    Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
    Plug 'derekwyatt/vim-fswitch'
    Plug 'majutsushi/tagbar'
    " 状态栏
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Git 包装器
    Plug 'tpope/vim-fugitive'
    Plug 'nathanaelkane/vim-indent-guides'
    " tags自动生成
    Plug 'ludovicchabant/vim-gutentags'
    " 静态代码检查
    Plug 'dense-analysis/ale'
    " SuperTab
    Plug 'ervandew/supertab'
    " 代码补全
    Plug 'ycm-core/YouCompleteMe' 
    " 代码片段
    Plug 'SirVer/ultisnips'
    " 大量代码片段
    Plug 'honza/vim-snippets'
    " 主题
    Plug 'lifepillar/vim-solarized8'
    Plug 'morhetz/gruvbox'
    " 语法高亮插件
    Plug 'sheerun/vim-polyglot'
    " 代码注释
    Plug 'tpope/vim-commentary'
    " 快速移动
    Plug 'easymotion/vim-easymotion'
    " Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    " Plug 'junegunn/fzf.vim'
    Plug 'mhinz/vim-grepper'
    " Plug 'airblade/vim-gitgutter'
    Plug 'mhinz/vim-signify'
    " 文件icon
    Plug 'ryanoasis/vim-devicons'
    " 更好用的增量搜索，模糊搜索
    Plug 'haya14busa/incsearch.vim'
    Plug 'haya14busa/incsearch-fuzzy.vim'
    " 编辑成对符号
    Plug 'tpope/vim-surround'
    " 能够智能的扩大/缩小选中区域。
    Plug 'terryma/vim-expand-region'
    " 自动补全成对符号
    " Plug 'jiangmiao/auto-pairs'
    Plug 'Shougo/echodoc.vim'
    " marker可视化
    Plug 'kshenoy/vim-signature'
    " 模糊搜索
    Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
    " Asyncrun
    Plug 'skywind3000/asyncrun.vim'
    Plug 'wakatime/vim-wakatime'
    Plug 'KabbAmine/zeavim.vim'
    Plug 'thaerkh/vim-workspace'
    Plug 'rhysd/vim-clang-format'
    Plug 'puremourning/vimspector'
    Plug 'vim-scripts/BufOnly.vim'
    " if has('nvim')
    "     Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
    " else
    "     Plug 'Shougo/defx.nvim'
    "     Plug 'roxma/nvim-yarp'
    "     Plug 'roxma/vim-hug-neovim-rpc'
    " endif
    call plug#end()
"}

" Theme {
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1 
    " set term=screen-256color
    if $COLORTERM == 'truecolor'
        " Enable true color 启用终端24位色 解决tmux中vim的显示问题
        if exists('+termguicolors')
            " termguicolors 用来开启真彩色，前面两行用来解决 vim 的 BUG
            " (neovim 不需要），其中 ^[ 是代表 ESC 键，需要在 vim 中按 Ctrl-v ESC 来输入。

            " fix bug for vim
            set t_8f=[38;2;%lu;%lu;%lum
            set t_8b=[48;2;%lu;%lu;%lum
            set termguicolors
        endif
    else
        set term=xterm
        set t_Co=256
    endif
    " 配色方案
    "let g:solarized_underline = 0 " disable underlining, esp. for folds
    "let g:solarized_termtrans = 1
    let g:solarized_italics = 0
    set background=dark
    colorscheme gruvbox
"}

" General {
    set encoding=UTF-8
    set updatetime=100
    " set guifont=DroidSansMono\ Nerd\ Font\ Mono\ 11
    " vim 自身命令行模式智能补全
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    syntax enable
    syntax on
    " 显示行号
    set number
    " 显示相对行号
    set rnu
    " 删除模式
    set backspace=2
    " 命令模式下，在底部显示，当前键入的指令
    set showcmd
    " utf-8
    set encoding=utf-8
    "set t_Co=256
    " 开启缩进
    filetype indent on
    " 将制表符扩展为空格
    set expandtab
    " 自动缩进
    set autoindent
    " tab shift按照空格处理
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    " 开启文件类型侦测
    filetype on 
    " 根据侦测到的不同类型加载对应的插件
    filetype plugin on
    " 开启实时搜索功能
    set incsearch
    " 搜索时大小写不敏感
    set ignorecase
    " 禁止光标闪烁
    set gcr=a:block-blinkon0
    " 禁止显示滚动条
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    " 禁止显示菜单和工具条
    set guioptions-=m
    set guioptions-=T
    " 总是显示状态栏
    set laststatus=2
    " 显示光标当前位置
    set ruler
    " 高亮显示当前行/列
    "set cursorline
    "set cursorcolumn
    " 高亮显示搜索结果
    set hlsearch
    " 禁止折行
    set nowrap
    " 基于缩进或语法进行代码折叠
    "set foldmethod=indent
    set foldmethod=syntax
    " 启动 vim 时关闭折叠代码
    set nofoldenable

    let &t_SI = "\e[6 q"
    let &t_EI = "\e[2 q"
"}

" Keymap {
    " 定义快捷键的前缀，即<Leader>
    let mapleader=" "
    nnoremap <leader>g :Grepper -tool git -noopen -jump<cr>
    "按esc顺便取消高亮
    " nnoremap <esc> <esc>:noh<CR>
    " nnoremap <C-[> <esc>:noh<CR>
    " fzf
    " nnoremap <silent> <C-p> :Files<CR>
    " LeaderF
    nnoremap <silent> <C-p> :LeaderfFile<CR>
    " 定义快捷键到行首和行尾
    nmap LB 0
    nmap LE $
    " 设置快捷键将选中文本块复制至系统剪贴板
    vnoremap <Leader>y "+y
    " 设置快捷键将系统剪贴板内容粘贴至 vim
    nmap <Leader>p "+p
    " 定义快捷键关闭当前分割窗口
    nmap <Leader>q :q<CR>
    " 定义快捷键保存当前窗口内容
    nmap <Leader>w :w<CR>
    " 定义快捷键保存所有窗口内容并退出 vim
    nmap <Leader>WQ :wa<CR>:q<CR>
    " 不做任何保存，直接退出 vim
    nmap <Leader>Q :qa!<CR>
    " 依次遍历子窗口
    "nnoremap nw <C-W><C-W>
    " 跳转至右方的窗口
    nnoremap <Leader>lw <C-W>l
    " 跳转至左方的窗口
    nnoremap <Leader>hw <C-W>h
    " 跳转至上方的子窗口
    nnoremap <Leader>kw <C-W>k
    " 跳转至下方的子窗口
    nnoremap <Leader>jw <C-W>j
    " 定义快捷键在结对符之间跳转
    nmap <Leader>M %
    " *.cpp 和 *.h 间切换
    " nmap <silent> <Leader>sw :FSHere<cr>

    " 正向遍历同名标签
    nmap <Leader>tn :tnext<CR>
    " 反向遍历同名标签
    nmap <Leader>tp :tprevious<CR>

    " 反向遍历tags
    nmap <silent> [t :tabprevious<CR>
    " 正向遍历同名标签
    nmap <silent> ]t :tabnext<CR>

    nnoremap <silent> [b :bprevious<CR>

    nnoremap <silent> ]b :bnext<CR>

    nnoremap <silent> [B :bfirst<CR>

    nnoremap <silent> ]B :blast<CR>
"}

" Plugins Configuration {
    " vimspector{
        let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
    " }
    "NERD {
        nmap <silent> <Leader>e :NERDTreeToggle <cr>
    "}
    "Defx {
        " nmap <silent> <Leader>e :Defx <cr>
        " call defx#custom#option('_', {
        "             \ 'winwidth': 30,
        "             \ 'split': 'vertical',
        "             \ 'direction': 'topleft',
        "             \ 'show_ignored_files': 0,
        "             \ 'buffer_name': '',
        "             \ 'toggle': 1,
        "             \ 'resume': 1
        "             \ })

       " autocmd FileType defx call s:defx_mappings()

       " function! s:defx_mappings() abort
        "    nnoremap <silent><buffer><expr> l     <SID>defx_toggle_tree()
        "    " 打开或者关闭文件夹，文件
        "    nnoremap <silent><buffer><expr> .
        "    defx#do_action('toggle_ignored_files')     " 显示隐藏文件
        "    nnoremap <silent><buffer><expr> <C-r>
        "    defx#do_action('redraw')
       " endfunction

       " function! s:defx_toggle_tree() abort
        "    " Open current file, or toggle directory expand/collapse
        "    if defx#is_directory()
        "        return
        "        defx#do_action('open_or_close_tree')
        "    endif
        "    return defx#do_action('multi',
        "    ['drop'])
       " endfunction
    " }
    " vim-workspace {
        let g:workspace_persist_undo_history = 0
    " }
    " asyncrun{
        " 自动打开 quickfix window ，高度为 6
        let g:asyncrun_open = 6

        " 任务结束时候响铃提醒
        let g:asyncrun_bell = 1

        " 设置 F10 打开/关闭 Quickfix 窗口
        nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
        nnoremap <silent> <leader><leader>c :AsyncRun g++ -g -Wall -O0 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
        nnoremap <silent> <leader><leader>r :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
        let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml'] 
    " }

    " echodoc{
        " To use echodoc, you must increase 'cmdheight' value.
        set cmdheight=2
        set noshowmode
        let g:echodoc_enable_at_startup = 1
        let g:echodoc#type = "echo"
    " }
    " Fswitch{
        " *.cpp 和 *.h 间切换
        nmap <silent> <Leader>sw :FSHere<cr>
    " }

    " multi_cursor{
        let g:multi_cursor_use_default_mapping=0
        " Default mapping
        let g:multi_cursor_start_word_key      = '<C-n>'
        let g:multi_cursor_select_all_word_key = '<A-n>'
        let g:multi_cursor_start_key           = 'g<C-n>'
        let g:multi_cursor_select_all_key      = 'g<A-n>'
        let g:multi_cursor_next_key            = '<C-n>'
        let g:multi_cursor_prev_key            = '<C-p>'
        let g:multi_cursor_skip_key            = '<C-x>'
        let g:multi_cursor_quit_key            = '<Esc>'
        " 性能优化，在multiple-cursor期间禁用一些插件
        function! Multiple_cursors_before()
            let s:old_ycm_whitelist = g:ycm_filetype_whitelist
            let g:ycm_filetype_whitelist = {}
            set foldmethod=manual
        endfunction
        function! Multiple_cursors_after()
            let g:ycm_filetype_whitelist = s:old_ycm_whitelist
            set foldmethod=indent
        endfunction
    " }

    " vim-expand-regsion{
        " v选择下个单词/段落 ctrl-v回退选择
        vmap v <Plug>(expand_region_expand)
        vmap <C-v> <Plug>(expand_region_shrink)
    "}

    " LeaderF {
        " let g:Lf_CommandMap = {'<c-k>': ['<Up>'], '<c-j>': ['<Down>']}
        " let g:Lf_ShortcutF = '<C-P>'
        " don't show the help in normal mode
        let g:Lf_HideHelp = 1
        let g:Lf_UseCache = 0
        let g:Lf_UseVersionControlTool = 0
        let g:Lf_IgnoreCurrentBufferName = 1
        " popup mode
        let g:Lf_WindowPosition = 'popup'
        let g:Lf_PreviewInPopup = 1
        let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
        let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

        let g:Lf_ShortcutF = "<leader>ff"
        noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
        noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
        noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
        noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

        noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
        noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
        " search visually selected text literally
        xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
        noremap go :<C-U>Leaderf! rg --recall<CR>

        " should use `Leaderf gtags --update` first
        let g:Lf_GtagsAutoGenerate = 0
        let g:Lf_Gtagslabel = 'native-pygments'
        noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
        noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
        noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
        noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
        noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
    " }

    " incsearch {
        " 高亮匹配字符
        " set incsearch
        " 替换默认搜索
        let g:incsearch#auto_nohlsearch = 1
        map n  <Plug>(incsearch-nohl-n)
        map N  <Plug>(incsearch-nohl-N)
        map *  <Plug>(incsearch-nohl-*)
        map #  <Plug>(incsearch-nohl-#)
        map g* <Plug>(incsearch-nohl-g*)
        map g# <Plug>(incsearch-nohl-g#)

        map /  <Plug>(incsearch-forward)
        map ?  <Plug>(incsearch-backward)
        map g/ <Plug>(incsearch-stay)

        function! s:config_fuzzyall(...) abort
            return extend(copy({
                        \   'converters': [
                        \     incsearch#config#fuzzy#converter(),
                        \     incsearch#config#fuzzyspell#converter()
                        \   ],
                        \ }), get(a:, 1, {}))
        endfunction

        noremap <silent><expr> z/ incsearch#go(<SID>config_fuzzyall())
        noremap <silent><expr> z? incsearch#go(<SID>config_fuzzyall({'command': '?'}))
        noremap <silent><expr> zg? incsearch#go(<SID>config_fuzzyall({'is_stay': 1}))
        " 模糊搜索
        " map z/ <Plug>(incsearch-fuzzy-/)
        " map z? <Plug>(incsearch-fuzzy-?)
        " map zg/ <Plug>(incsearch-fuzzy-stay)
        " 带拼写纠正的模糊搜索
        " map z/ <Plug>(incsearch-fuzzy-/)
        " map z? <Plug>(incsearch-fuzzy-?)
        " map zg/ <Plug>(incsearch-fuzzy-stay)
    " }

    " vim-easymotion{
        " 智能大小写匹配
        let g:EasyMotion_smartcase = 1

        " <Leader>f{char} to move to {char}
        " map  <Leader>f <Plug>(easymotion-bd-f2)
        " nmap <Leader>f <Plug>(easymotion-overwin-f)

        " s{char}{char} to move to {char}{char}
        nmap s <Plug>(easymotion-bd-f2)

        " Move to line
        map <Leader>L <Plug>(easymotion-bd-jk)
        " nmap <Leader>L <Plug>(easymotion-overwin-line)

        " Move to word
        map  <Leader>w <Plug>(easymotion-bd-w)
        " nmap <Leader>w <Plug>(easymotion-overwin-w)
    " }

    " ale {
        " 对应语言需要安装相应的检查工具
        " https://github.com/w0rp/ale
        "    let g:ale_linters_explicit = 1 "除g:ale_linters指定，其他不可用
        "    let g:ale_linters = {
        "\   'cpp': ['cppcheck','clang','gcc'],
        "\   'c': ['cppcheck','clang', 'gcc'],
        "\   'python': ['pylint'],
        "\   'bash': ['shellcheck'],
        "\   'go': ['golint'],
        "\}
        let g:ale_linters = {
            \ 'cpp': ['cppcheck','clang'],
            \ 'c': ['cppcheck','clang'],
            \ 'python': ['flake8','pylint3'],
            \}
        let g:ale_sign_column_always = 1
        "let g:ale_completion_delay = 500
        "let g:ale_echo_delay = 20
        "let g:ale_lint_delay = 500
        let g:ale_echo_msg_format = '[%linter%] %code: %%s'
        let g:ale_lint_on_text_changed = 'normal'
        let g:ale_lint_on_insert_leave = 1
        let g:airline#extensions#ale#enabled = 1
        "let g:ale_set_quickfix = 1
        "let g:ale_open_list = 1"打开quitfix对话框
        let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
        let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
        let g:ale_c_cppcheck_options = '-Wall -O2 -std=c99'
        let g:ale_cpp_cppcheck_options = '-Wall -O2 -std=c++14'

        let g:ale_sign_error = ">>"
        let g:ale_sign_warning = "--"
        map <F7> :ALEToggle<CR>
    " }

    " Universal CTags {
        " './.tags'表示文件所在的目录下的.tags文件，
        " ';'表示代表查找不到的话向上递归到父目录，直到找到'.tags'文件或者递归到了根目录还没找到
        " ','分隔符
        " '.tags'表示vim当前所在的目录（:pwd命令返回的目录）
        set tags=./tags;/,tags
    " }    

    " vim-gutentags {
        " gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
        let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

        " 所生成的数据文件的名称
        let g:gutentags_ctags_tagfile = 'tags'

        " 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
        let s:vim_tags = expand('~/.cache/tags')
        let g:gutentags_cache_dir = s:vim_tags

        " 配置 ctags 的参数
        let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
        let g:gutentags_ctags_extra_args += ['--c++-kinds=+lpx']
        let g:gutentags_ctags_extra_args += ['--c-kinds=+lpx']
    "}

    " Indent Guides {
        " 随 vim 自启动
        let g:indent_guides_enable_on_vim_startup=1
        " 从第二层开始可视化显示缩进
        let g:indent_guides_start_level=3
        " 色块宽度
        let g:indent_guides_guide_size=1
        " 快捷键 i 开/关缩进可视化
        nmap <silent> <Leader>i <Plug>IndentGuidesToggle     
    " }
    
    " Tagbar {
        " 设置 tagbar 子窗口的位置出现在主编辑区的左边 
        let tagbar_left=1 
        " 设置显示／隐藏标签列表子窗口的快捷键。速记：identifier list by tag
        nnoremap <Leader>ilt :TagbarToggle<CR> 
        " 设置标签子窗口的宽度 
        let tagbar_width=32 
        " tagbar 子窗口中不显示冗余帮助信息 
        let g:tagbar_compact=1
        " 设置 ctags 对哪些代码标识符生成标签
        let g:tagbar_type_cpp = {
            \ 'kinds' : [
                 \ 'c:classes:0:1',
                 \ 'd:macros:0:1',
                 \ 'e:enumerators:0:0', 
                 \ 'f:functions:0:1',
                 \ 'g:enumeration:0:1',
                 \ 'l:local:0:1',
                 \ 'm:members:0:1',
                 \ 'n:namespaces:0:1',
                 \ 'p:functions_prototypes:0:1',
                 \ 's:structs:0:1',
                 \ 't:typedefs:0:1',
                 \ 'u:unions:0:1',
                 \ 'v:global:0:1',
                 \ 'x:external:0:1'
             \ ],
             \ 'sro'        : '::',
             \ 'kind2scope' : {
                 \ 'g' : 'enum',
                 \ 'n' : 'namespace',
                 \ 'c' : 'class',
                 \ 's' : 'struct',
                 \ 'u' : 'union'
             \ },
             \ 'scope2kind' : {
                 \ 'enum'      : 'g',
                 \ 'namespace' : 'n',
                 \ 'class'     : 'c',
                 \ 'struct'    : 's',
                 \ 'union'     : 'u'
             \ }
        \ }
    "}

    " Snippets {
        " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
        let g:UltiSnipsExpandTrigger="<tab>"
        let g:UltiSnipsJumpForwardTrigger="<tab>"
        let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

        " If you want :UltiSnipsEdit to split your window.
        let g:UltiSnipsEditSplit="vertical"

    " }

    " YouCompleteMe {
        " 开启 YCM 基于标签引擎
        let g:ycm_collect_identifiers_from_tags_files = 1           
        " 注释与字符串中的内容也用于补全
        let g:ycm_collect_identifiers_from_comments_and_strings = 1 
        " let g:syntastic_ignore_files=[".*\.py$"]
        " 语法关键字补全
        let g:ycm_seed_identifiers_with_syntax = 1                  
        let g:ycm_confirm_extra_conf = 0
        let g:ycm_min_num_identifier_candidate_chars = 2 "触发补全的字符数
        " 映射按键, 没有这个会拦截掉tab, 导致其他插件的tab不能用.
        " 使YCM支持UltiSnips插件,自动补全代码片段
        let g:ycm_key_list_select_completion = []
        let g:ycm_key_list_previous_completion = []
        let g:ycm_max_diagnostics_to_display = 0
        let g:SuperTabDefaultCompletionType = '<c-n>'
        let g:ycm_key_invoke_completion = '<c-z>'
        " 在注释输入中也能补全
        let g:ycm_complete_in_comments = 1                          
        " 在字符串输入中也能补全
        let g:ycm_complete_in_strings = 1                           
        " 注释和字符串中的文字也会被收入补全
        let g:ycm_collect_identifiers_from_comments_and_strings = 1 
        " 禁用语法检查
        let g:ycm_show_diagnostics_ui = 0                           
        " let g:ycm_use_ultisnips_completer = 1
        "let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
        " 强制输入两个字符后触发语义补全
        " let g:ycm_semantic_triggers = {'c,cpp,python,java,go,erlang,perl': ['re!\w{3}'],'cs,lua,javascript': ['re!\w{2}'] }
        "在实现和声明之间跳转,并分屏打开
        " let g:ycm_goto_buffer_command = 'horizontal-split'
        set completeopt=menu,menuone
        let g:ycm_add_preview_to_completeopt = 0
        nnoremap <Leader>g :YcmCompleter GoTo<CR>
    "}
"}

" 让配置变更立即生效,如果:w ~/.myvimrc,就source
autocmd BufWritePost ~/.vimrc  source ~/.vimrc 

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
