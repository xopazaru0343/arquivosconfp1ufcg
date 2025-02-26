" Configuração Vim para p1 Computação@UFCG 
" Dalton Serey, UFCG (2023)
"
" Atenção. Este arquivo é apenas uma referência para você criar seu
" próprio arquivo de configuração. Bons arquivos de configuração
" são *sempre* personalizados. Por isso, crie seu arquivo pessoal
" de configuração e, aos poucos, vá adicionando seus próprios
" ajustes e configurações. Pra isso, você pode estudar a
" documentação inteira do vim ou, o que é mais fácil, ir estudando
" sob demanda. Quando você quiser que seu vim funcione um pouco
" diferente, é hora de aprender como configurá-lo para atender a
" sua necessidade. Quando aprender, ajuste seu arquivo de
" configuração, deixando um comentário que facilite sua vida numa
" próxima oportunidade em que você precise fazer um novo ajuste na
" configuração. E, assim, vá aprendendo e ajustando o vim a suas
" necessidades.

" configura a tecla leader
let mapleader = '='

" largura default de texto
set textwidth=65

" por default, usa numeração de linhas
set number

" trata o tab e a tabulação com espaços
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" toggle numeração de linhas
noremap <leader>m :set number!<Enter>

" faz backspace funcionar de forma mais intuituiva
set backspace=indent,eol,start

" habilita o uso do mouse
set mouse=a

" ativa o reconhecimento de sintaxe
syntax on

" configura auto indentação (e toggle)
set autoindent
nnoremap <leader>ai :set autoindent!<cr>
noremap <leader><Tab> :set autoindent!<Enter>
inoremap <leader><Tab> jk:set autoindent!<Enter>i

" formatação de parágrafo com <leader>-p
nnoremap <leader>p m9gqap`9
:inoremap <leader><leader>p :pdb:
setlocal formatoptions+=l " evita quebra de linhas longas


" configura o highlight do search
set hlsearch
hi Search ctermbg=226 ctermfg=black
nnoremap <leader>s :set hlsearch!<cr>

" macros/snippets estilo antigo (para debugging python)
let @c = 'Oimport code; code.interact(local=locals())'
let @i = 'Oimport pdb; pdb.set_trace()'
let @o = 'Oimport pudb; pu.db'
let @p = 'Ofrom remote_pdb import RemotePdb; RemotePdb("127.0.0.1", 4444).set_trace()jkddkP'

" suporte para clipboard do sistema (yank, paste, C-c C-v)
set clipboard=unnamedplus

" split de tela com keymaps similares aos do tmux
" (cuidado para não usar o mesmo prefixo que o tmux)
nmap <c-d>- :new<cr>
nmap <c-d>= :vnew<cr>

" desabilita relativenumber em buffers sem foco
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" função de apoio para abbrevs (ver :helpgrep Eatchar)
function! Eatchar(pat) 
    let c = nr2char(getchar()) 
    return (c =~ a:pat) ? '' : c 
endfunction


" caracteres especiais abreviados
" 
" Usar Eatchar como abaixo, caso se deseje eliminar
" o espaço adicionado na expansão. Caso não se queira
" a expansão, ainda pode ser usado o <C-]>
" :iabbr <silent> :dsg: dalton<c-r>=Eatchar('\s')<cr>
abbreviate :<": “
abbreviate :">: ”
abbreviate :->: →
abbreviate :<-: ←
abbreviate :=>: ⇒
abbreviate :<=: ⇐
abbreviate :<->: ↔
abbreviate :<=>: ⇔
abbreviate :v: ✅
abbreviate :check: ✅
abbreviate :x: ×
abbreviate :X: ❌
abbreviate :sad: 😞
abbreviate :clap: 👏
abbreviate :think: 🤔
abbreviate :!=: ≠
abbreviate :ellipsis: …
abbreviate :...: …
abbreviate :---: —
abbreviate :dash: —
abbreviate :times: × 
abbreviate :<=: ≤
abbreviate :>=: ≥

" faz scroll do texto mantendo cursor na mesma posição
nnoremap <C-x> <C-e><Down>
nnoremap <C-Down> <C-y><Up>

" faz scroll quando o cursor chega a N linhas do limite
set scrolloff=3

" tratamento de linhas longas
" - usa soft breaks (não quebrar palavras no wrapping)
" - TODO: recolocar pra augroups: depende do tipo de texto
set nolist wrap linebreak
noremap <leader>w :set wrap!<Enter> <bar> :set linebreak<Enter> <bar> :set textwidth=0<Enter>
set breakindent
set showbreak=>
set breakindent
set cpoptions+=n
set breakindentopt=shift:0,min:0,sbr " breakindentopt apropriado para texto

" faz setas funcionarem em insert mode com soft break/wrap
" (permite descer/subir em uma linha longa que é exibida em
" múltiplas linhas com wrap; se usar j ou k o cursor irá para
" a próxima linha real; esta configuração mantém os dois
" comportamentos: as setas movimentarão o cursor uma linha na
" tela, enquanto j e k movimentarão uma linha do buffer)
nnoremap <Down> gj
nnoremap <Up> gk

" configuração default de listas e bullets (list mode)
" (TODO: levar para augroups: depende do tipo de texto)
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set nolist
nnoremap <leader>l :set list!<cr>

" mostra parcialmente a última linha, caso não caiba
" (por default, se a última linha do buffer precisar ocupar
" mais linhas do que há disponível na tela, o vim exibirá
" um @ apenas no início da linha; esta configuração faz o
" vim exibir apenas as linhas que caibam)
set display+=lastline

" suporte a múltiplos buffers simultâneos
set hidden " permite mudar de buffers sem precisar gravar
set showtabline=2 " sempre mostra o tabline

" usar tab para mudar para o próximo tab
noremap <Tab> :bn<Enter> 

" usar tab e Shift-Tab para alternar entre buffers abertos
noremap <S-Tab> :bp<Enter>


" configura statusline
set laststatus=2        " ativa o statusline
set statusline=%F       " path do arquivo
set statusline+=\       " separador
set statusline+=%y      " tipo de arquivo
set statusline+=\ %l    " linha atual
set statusline+=/       " separador
set statusline+=%L      " total de linhas
set statusline+=\ %c    " coluna atual

" ============================================
" Outros maps e abbrevs
" ============================================

" Para editar e ler rapidamente este arquivo 
nnoremap <leader>[ :e $MYVIMRC<cr>
nnoremap <leader>] :source $MYVIMRC<cr>

" ============================================
" Autocommands
" ============================================

" markdown
augroup md
    " reinicia formatoptions ao valor default
    setlocal formatoptions=tcq
   
    " Permite formatar parágrafos automaticamente
"    setlocal formatoptions+=a

    " Permite formatar listas numeradas
    " (não usar com option '2'; pressupõe uso de autoindent)
    setlocal formatoptions+=n
augroup end

" clojure
augroup clj
    autocmd BufNewFile,BufRead *.clj setlocal nowrap
    autocmd BufNewFile,BufRead *.clj set textwidth=0
    autocmd BufNewFile,BufRead *.clj highlight clear OverLength
    autocmd BufNewFile,BufRead *.clj set tabstop=2
    autocmd BufNewFile,BufRead *.clj set softtabstop=2
    autocmd BufNewFile,BufRead *.clj set shiftwidth=2
augroup end

" html5
augroup html
    autocmd BufNewFile,BufRead *.html setlocal nowrap
    autocmd BufNewFile,BufRead *.html set textwidth=0
    autocmd BufNewFile,BufRead *.html highlight clear OverLength
    "autocmd FileType html,css EmmetInstall
    autocmd BufNewFile,BufRead *.html set tabstop=2
    autocmd BufNewFile,BufRead *.html set softtabstop=2
    autocmd BufNewFile,BufRead *.html set shiftwidth=2
"    autocmd BufNewFile,BufRead *.html inoreabbrev div <div></div><Esc>5hi<C-R>=Eatchar('\s')<CR>
"    autocmd BufNewFile,BufRead *.html inoreabbrev html <html></html><Esc>6hi<cr><cr>k<C-R>=Eatchar('\s')<CR>
"    autocmd BufNewFile,BufRead *.html inoreabbrev head <head></head><Esc>6hi<C-R>=Eatchar('\s')<CR>
"    autocmd BufNewFile,BufRead *.html inoreabbrev body <body></body><Esc>6hi<C-R>=Eatchar('\s')<CR>
"    autocmd BufNewFile,BufRead *.html inoreabbrev p <p></p><Esc>6hi<C-R>=Eatchar('\s')<CR>
augroup end

" javascript
augroup js
    autocmd BufNewFile,BufRead *.js setlocal nowrap
    autocmd BufNewFile,BufRead *.js set textwidth=0
    autocmd BufNewFile,BufRead *.js highlight clear OverLength
    autocmd BufNewFile,BufRead *.js set tabstop=4
    autocmd BufNewFile,BufRead *.js set softtabstop=4
    autocmd BufNewFile,BufRead *.js set shiftwidth=4
augroup end

" python
augroup py
    autocmd BufNewFile,BufRead *.py :highlight Comment ctermfg=Green
    autocmd BufNewFile,BufRead *.py setlocal nowrap
    autocmd BufNewFile,BufRead *.py set textwidth=0
    "autocmd BufNewFile,BufRead *.py highlight clear OverLength
    "autocmd BufNewFile,BufRead *.py match OverLength /\%120v.*/
    autocmd BufNewFile,BufRead *.py set tabstop=4
    autocmd BufNewFile,BufRead *.py set softtabstop=4
    autocmd BufNewFile,BufRead *.py set shiftwidth=4
    autocmd BufNewFile,BufRead *.py set wrap
    autocmd BufNewFile,BufRead *.py set linebreak
    autocmd BufNewFile,BufRead *.py set textwidth=0
    autocmd BufNewFile,BufRead *.py set breakindentopt=shift:6,min:40,sbr
    autocmd BufNewFile,BufRead *.py syntax match pyOperator "<=" conceal cchar=M
    autocmd BufNewFile,BufRead *.py set breakindentopt=shift:10,min:0,sbr
augroup end

" =====================
" Configurações Visuais
" =====================

" cores do texto e fundo principais
highlight Normal ctermfg=white ctermbg=233

" cores da numeração de linhas
highlight LineNr ctermfg=237 ctermbg=234

" cores do tabline e do statusline
hi TabLineSel   cterm=bold,reverse  ctermbg=255         ctermfg=DarkBlue 
hi TabLine      cterm=reverse       ctermbg=255         ctermfg=DarkBlue
hi TabLineFill  cterm=reverse       ctermbg=None        ctermfg=DarkBlue 
hi StatusLine   cterm=bold,reverse  ctermbg=255         ctermfg=DarkBlue

" esquema geral de cores
colorscheme gruvbox
set background=dark
