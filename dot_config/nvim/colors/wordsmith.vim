" wpordsmith 0.1.1
" author: Arvid - www.rmrf.se

highlight clear
if exists("syntax_on")
    syntax reset
endif

set background=light
" set g:colors_name="wordsmith"

highlight Normal guibg=white guifg=black

highlight StatusLine guibg=white guifg=black

highlight Search    guibg=gray85 guifg=black
highlight CurSearch guibg=white guifg=black gui=bold,italic

highlight Cursor        guifg=white
highlight CursorLine    guibg=gray85 guifg=black
highlight ColorColumn   guibg=gray85

highlight Comment guifg=gray25 gui=italic

highlight Constant  guifg=black
highlight String    guifg=black  gui=italic
highlight Character guifg=black
highlight Number    guifg=black
highlight Boolean   guifg=black gui=bold
highlight Float     guifg=black

highlight Identifier    guifg=black  gui=bold
highlight Function      guifg=black

highlight Statement     guifg=black  " any statement
highlight Conditional   guifg=black  " if, then, else, endif, switch, etc.
highlight Repeat        guifg=black  " for, do, while, etc.
highlight Label         guifg=black  " case, default, etc.
highlight Operator      guifg=black  " "sizeof", "+", "*", etc.
highlight Keyword       guifg=black  " any other keyword
highlight Exception     guifg=black  " try, catch, throw

highlight PreProc   guifg=black  " generic Preprocessor
highlight Include   guifg=black  " preprocessor #include
highlight Define    guifg=black  " preprocessor #define
highlight Macro     guifg=black  " same as Define
highlight PreCondit guifg=black  " preprocessor #if, #else, #endif, etc.

highlight Type          guifg=black  " int, long, char, etc.
highlight StorageClass  guifg=black  " static, register, volatile, etc.
highlight Structure     guifg=black  " struct, union, enum, etc.
highlight Typedef       guifg=black  " a typedef

highlight Special           guifg=black  " any special symbol
highlight SpecialChar       guifg=black  " special character in a constant
highlight Tag               guifg=black  " you can use CTRL-] on this
highlight Delimiter         guifg=black  " character that needs attention
highlight SpecialComment    guifg=black  " special things inside a comment
highlight Debug             guifg=black  " debugging statements

highlight Underlined guifg=black " text that stands out, HTML links

highlight Ignore guifg=black " left blank, hidden  |hl-Ignore|

highlight Error guifg=black gui=undercurl " any erroneous construct

highlight Todo guifg=black gui=reverse  " anything that needs extra attention;
                                        " mostly the keywords TODO FIXME and
                                        " XXX

highlight Added     guifg=black gui=underline   " added line in a diff
highlight Changed   guifg=black gui=undercurl   " changed line in a diff
highlight Removed   guifg=black gui=underdotted " removed line in a diff


highlight Pmenu guibg=gray85 guifg=black

highlight Visual guibg=gray85 guifg=black
highlight ModeMsg guibg=white guifg=black
