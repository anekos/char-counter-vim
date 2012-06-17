" Sun Jun 17 17:07:49 JST 2012
"
" b:charCounterCount に文字数をセットするスクリプト
" バッファを保存したりしたときに、更新される。
"
" ステータスラインに入れて使う例↓
" set statusline=%{b:charCounterCount}

if exists("anekos_charCounter")
	finish
endif
let anekos_charCounter=1

augroup CharCounter
	autocmd!
	autocmd BufCreate,BufEnter * call <SID>Initialize()
	autocmd BufUnload,FileWritePre,BufWritePre * call <SID>Update()
augroup END

function! s:Initialize()
	if exists('b:charCounterCount')
	else
		return s:Update()
	endif
endfunction

function! s:Update()
	let b:charCounterCount = s:CharCount()
endfunction

function! s:CharCount()
	let l:result = 0
	for l:linenum in range(0, line('$'))
		let l:line = getline(l:linenum)
		let l:result += strlen(substitute(l:line, ".", "x", "g"))
	endfor
	return l:result
endfunction

function! AnekoS_CharCounter_CharCount()
	return s:CharCount()
endfunction


