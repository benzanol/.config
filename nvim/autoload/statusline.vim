function! statusline#Initialize()
	" Set the left and right separator
	let s:left_separator = "❱"
	let s:right_separator = "❰"

	call s:PrepareModules()
	call s:PrepareColors()

	command SimpleStatusline call s:SetStatuslineType(0)
	command ComplexStatusline call s:SetStatuslineType(1)
	command ToggleStatusline call s:SetStatuslineType(-1)
	nnoremap <leader>ss :ToggleStatusline<CR>

	let g:sttype = 0
	call s:SetStatuslineType(g:sttype)
endfunction

function! s:SetStatuslineType(arg) " {{{1
	if a:arg == 0
		let g:sttype = 0
		hi StatusLineNC cterm=strikethrough gui=strikethrough
		exec "set statusline=\\ "
		set laststatus=0

	elseif a:arg == 1
		let g:sttype = 1
		hi StatusLineNC cterm=underline gui=underline
		exec "set statusline=" . statusline#ComplexStatusline()
		set laststatus=2

	else
		let g:sttype = !g:sttype
		call s:SetStatuslineType(g:sttype)
	endif
endfunction " }}}
function! s:PrepareModules() " {{{1
	" Set a template for statusline modules
	let s:left_modules = [
				\ {"value":"statusline#ShortLine()", "color":"StatuslineText"},
				\ {"value":"statusline#Mode()", "color":"StatuslineMode"},
				\ {"value":"'" . s:left_separator . "'", "color":"StatuslineSeparator"},
				\ {"value":"statusline#BufferName()", "color":"StatuslineText", "min":10},
				\ {"value":"'" . s:left_separator . "'", "color":"StatuslineSeparator"}]
	let s:right_modules = [
				\ {"value":"'" . s:right_separator . "'", "color":"StatuslineSeparator"},
				\ {"value":"statusline#Errors()", "color":"StatuslineError"},
				\ {"value":"statusline#Warnings()", "color":"StatuslineWarning"},
				\ {"value":"'" . s:right_separator . "'", "color":"StatuslineSeparator"},
				\ {"value":"statusline#CursorLocation()", "color":"StatuslineText"}]
endfunction " }}}
function! s:PrepareColors() " {{{1
	call g:HL("StatuslineText", "", "", "bold")
	call g:HL("StatuslineSeparator", "", "", "bold")
	call g:HL("Strikethrough", "", "", "strikethrough")
	call g:HL("InactiveStrikethrough", g:colors.grey3, "", "strikethrough")

	call g:HL("NormalMode", g:colors.blue, "", "bold")
	call g:HL("CommandMode", g:colors.purple, "", "bold")
	call g:HL("InsertMode", g:colors.yellow, "", "bold")
	call g:HL("VisualMode", g:colors.red, "", "bold")
	call g:HL("ReplaceMode", g:colors.green, "", "bold")
	hi def link ModeColor NormalModeColor

	call g:HL("StatuslineError", g:colors.red, "", "bold")
	call g:HL("StatuslineWarning", g:colors.yellow, "", "bold")
endfunction " }}}

function! statusline#ComplexStatusline() " {{{1
	" Create starting module
	let status_string = "%{statusline#Start()}"

	" Create left modules
	for q in s:left_modules
		let status_string .= s:AddModule(q)
	endfor

	" Create space in the center
	let status_string .= s:AddModule({"value":"''", "color":"StatuslineText"})
	let status_string .= "%#UtterNonsense#%="

	" Create left modules
	for q in s:right_modules
		let status_string .= s:AddModule(q)
	endfor
	
	return status_string
endfunction " }}}
function! s:AddModule(module) " {{{1
	let string = "%#StatusLineNC#"
	let string .= "%{statusline#Return('\\ ',0)}"
	let string .= "%-0{statusline#Return(" . a:module.value . ",0)}"

	let string .= "%#" . a:module.color . "#"
	let string .= "%{statusline#Return('\\ ',1)}"
	let string .= "%-0{statusline#Return(" . a:module.value . ",1)}"
	
	return string
endfunction " }}}

function! statusline#Return(text, type) " {{{1
	if s:shortened == 2
		return ""
	endif

	if a:type != (bufnr() == g:actual_curbuf)
		return ""
	else
		let s:width += len(substitute(a:text, ".", "-", "g"))
	endif

	if s:shortened == 1
		let s:shortened = 2
		return a:text
	elseif s:width <= winwidth(0)
		return a:text
	else
		return ""
	endif
endfunction " }}}
function! statusline#Start() " {{{1
	let s:width = 0
	let s:shortened = 0
	return ""
endfunction " }}}
function! statusline#ShortLine() " {{{1
	let name = statusline#BufferName()
	if winwidth(0) <= len(name) + 5
		let s:shortened = 1
		return name
	endif
	return ""
endfunction " }}}
function! statusline#Mode() " {{{1
	if mode() == "n"
		hi! def link StatuslineMode NormalMode
		return "N"
	elseif mode() == "c"
		hi! def link StatuslineMode CommandMode
		return "C"
	elseif mode() == "i"
		hi! def link StatuslineMode InsertMode
		return "I"
	elseif mode() == "v" || mode() == ""
		hi! def link StatuslineMode VisualMode
		return "V"
	elseif mode() == "r"
		hi! def link StatuslineMode ReplaceMode
		return "R"
	elseif mode() == "t"
		hi! def link StatuslineMode ReplaceMode
		return "T"
	else
		return "'" . mode() . "'"
	endif
endfunction " }}}
function! statusline#BufferName() " {{{1
	let name = expand("%:t")
	if name == ""
		return "[No Name]"
	else
		return name
	endif
endfunction " }}}
function! statusline#Errors() " {{{1
	let error_ct = ale#statusline#Count(bufnr()).error + ale#statusline#Count(bufnr()).style_error
	return (" " . error_ct)
endfunction " }}}
function! statusline#Warnings() " {{{
	let warning_ct = ale#statusline#Count(" . buffer . ").warning + ale#statusline#Count(" . buffer . ").style_warning
	return (" " . warning_ct)
endfunction " }}}
function! statusline#CursorLocation() " {{{1
	let coords = line(".") . "/" . col(".")
	let percent = round(100 * line(".") / line("$"))
	return coords . "\ \ " . string(percent)[0:-3] . "%"
endfunction " }}}
