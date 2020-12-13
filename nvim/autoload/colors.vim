function! colors#Initialize()
	" Prepare for setting up colors
	highlight clear
	syntax on
	syntax reset
	set t_Co=256
	filetype plugin on
	set background=dark
	
	call s:ColorVariables()
	call s:HighlightFunction()
	call s:ColorGroups()
	call s:StatuslineColors()
endfunction

function! s:ColorVariables() " {{{1
	let g:colors = {}
	let g:colors.fg = {"gui": "#D0D0D0", "cterm": "188"}
	let g:colors.white = {"gui": "#D3D7DB", "cterm": "188"}
	let g:colors.grey1 = {"gui": "#A4A8AC", "cterm": "248"}
	let g:colors.grey2 = {"gui": "#7C8084", "cterm": "244"}
	let g:colors.grey3 = {"gui": "#444444", "cterm": "238"}
	let g:colors.black = {"gui": "#0E1216", "cterm": "233"}
	let g:colors.red = {"gui": "#D75F5F", "cterm": "167"}
	let g:colors.yellow = {"gui": "#FFD75F", "cterm": "221"}
	let g:colors.green = {"gui": "#5FFF5F", "cterm": "083"}
	let g:colors.cyan = {"gui": "#5FFFD7", "cterm": "086"}
	let g:colors.blue = {"gui": "#5FAFD7", "cterm": "074"}
	let g:colors.purple = {"gui": "#AF87D7", "cterm": "140"}

	let g:colors.sidebar = {"gui": "#1B1D24", "cterm": "0"}
	let g:colors.bg = {"gui": "#22252C", "cterm": "8"}
	let g:colors.active_bg = g:colors.bg
	let g:colors.popup = {"gui": "#30343C", "cterm": "4"}
endfunction " }}} " }}}
function! s:HighlightFunction() " {{{1
	function! g:HL(group, fg, bg, attr)
		if type(a:fg) == type({})
			exec "hi " . a:group . " guifg=" . a:fg.gui . " ctermfg=" . a:fg.cterm
		endif

		if type(a:bg) == type({})
			exec "hi " . a:group . " guibg=" . a:bg.gui . " ctermbg=" . a:bg.cterm
		endif

		let attr = (a:attr == "") ? "NONE" : a:attr
		exec "hi " . a:group . " gui=" . attr . " cterm=" . attr
	endfun
endfunction " }}}
function! s:ColorGroups() " {{{1
	call g:HL("Regular", g:colors.fg, g:colors.bg, "")
	call g:HL("Normal", g:colors.fg, g:colors.bg, "")
	call g:HL("NonText", g:colors.grey2, "", "")

	call g:HL("Cursor", "", g:colors.grey2, "")
	call g:HL("CursorColumn", "", "", "")
	call g:HL("CursorLine", "", "", "bold")
	call g:HL("LineNr", g:colors.grey2, "", "")
	call g:HL("CursorLineNr", g:colors.white, g:colors.popup, "bold")
	call g:HL("EndOfBuffer", g:colors.bg, "", "")
	call g:HL("MsgArea", "", g:colors.sidebar, "")

	call g:HL("DiffAdd", g:colors.white, "", "")
	call g:HL("DiffChange", g:colors.white, "", "")
	call g:HL("DiffDelete", g:colors.red, "", "")
	call g:HL("DiffText", g:colors.blue, "", "")
	call g:HL("ModeMsg", g:colors.yellow, "", "")
	call g:HL("MoreMsg", g:colors.yellow, "", "")
	call g:HL("WarningMsg", g:colors.yellow, g:colors.bg, "italic")
	call g:HL("Question", g:colors.purple, "", "")
	call g:HL("MatchParen", g:colors.purple, g:colors.bg, "bold")

	call g:HL("Pmenu", g:colors.white, g:colors.popup, "")
	call g:HL("PmenuSel", g:colors.black, g:colors.blue, "bold")
	call g:HL("PmenuSbar", "", "", "")
	call g:HL("PmenuThumb", "", g:colors.white, "")

	call g:HL("SpellBad", g:colors.red, "", "")
	call g:HL("SpellCap", g:colors.yellow, "", "")
	call g:HL("SpellLocal", g:colors.yellow, "", "")
	call g:HL("SpellRare", g:colors.yellow, "", "")

	call g:HL("StatusLine", g:colors.fg, g:colors.sidebar, "bold")
	call g:HL("StatusLineNC", g:colors.fg, g:colors.grey3, "")
	call g:HL("TabLine", g:colors.fg, g:colors.bg, "none")
	call g:HL("TabLineSel", g:colors.white, g:colors.bg, "bold")
	call g:HL("TabLineFill", "", "", "none")

	call g:HL("Visual", "", g:colors.popup, "")
	call g:HL("VisualNOS", "", "", "")

	call g:HL("ColorColumn", "", "", "")
	call g:HL("Conceal", g:colors.white, "", "")
	call g:HL("Directory", g:colors.blue, "", "")
	call g:HL("VertSplit", g:colors.grey2, g:colors.bg, "")
	call g:HL("Folded", g:colors.grey2, g:colors.bg, "")
	call g:HL("FoldColumn", g:colors.grey2, g:colors.bg, "")
	call g:HL("SignColumn", "", g:colors.bg, "")

	call g:HL("SpecialKey", g:colors.grey2, "", "")
	call g:HL("Title", g:colors.green, "", "")
	call g:HL("WildMenu", g:colors.white, "", "")

	call g:HL("Comment", g:colors.grey2, "", "italic")
	call g:HL("SpecialComment", g:colors.grey2, "", "italic,bold")
	call g:HL("String", g:colors.green, "", "")
	call g:HL("Character", g:colors.green, "", "")
	call g:HL("Constant", "", "", "")
	call g:HL("Number", "", "", "")
	call g:HL("Boolean", "", "", "")
	call g:HL("Float", "", "", "")
	call g:HL("Special", g:colors.yellow, "", "bold")

	call g:HL("Conditional", g:colors.yellow, "", "bold")
	call g:HL("Repeat", g:colors.yellow, "", "bold")
	call g:HL("Label", g:colors.yellow, "", "bold")
	call g:HL("Keyword", g:colors.yellow, "", "bold")
	call g:HL("Exception", g:colors.yellow, "", "bold")

	call g:HL("Identifier", g:colors.white, "", "")
	call g:HL("Function", g:colors.blue, "", "")
	call g:HL("Statement", g:colors.red, "", "bold")

	call g:HL("PreProc", g:colors.yellow, "", "")
	call g:HL("Include", g:colors.yellow, "", "")
	call g:HL("Define", g:colors.yellow, "", "")
	call g:HL("Macro", g:colors.yellow, "", "")
	call g:HL("PreCondit", g:colors.yellow, "", "")

	call g:HL("Type", g:colors.yellow, "", "")
	call g:HL("StorageClass", g:colors.red, "", "")
	call g:HL("Structure", g:colors.yellow, "", "")
	call g:HL("Typedef", g:colors.yellow, "", "")

	call g:HL("Operator", g:colors.purple, "", "bold")
	call g:HL("SpecialChar", g:colors.white, "", "")
	call g:HL("Tag", g:colors.white, "", "")
	call g:HL("Delimiter", g:colors.white, "", "")
	call g:HL("Debug", g:colors.yellow, "", "")
	call g:HL("Underlined", g:colors.yellow, "", "")
	call g:HL("Ignore", g:colors.yellow, "", "")
	call g:HL("Error", g:colors.red, g:colors.bg, "italic")
	call g:HL("Todo", g:colors.yellow, g:colors.bg, "")
endfunction " }}}
function! s:StatuslineColors() " {{{1
	let g:colors.sline1 = {"gui":"#00004F", "cterm":17}
	let g:colors.sline2 = {"gui":"#0000AF", "cterm":19}
	let g:colors.sline3 = {"gui":"#0000FF", "cterm":21}
	for i in range(1, 3)
		exec "let stcol = g:colors.sline" . i
		call g:HL("StatuslineColor" . i, g:colors.fg, stcol, "bold")
	endfor

	call g:HL("StatuslineError", g:colors.red, g:colors.sline2, "bold")
	call g:HL("StatuslineWarning", g:colors.yellow, g:colors.sline2, "bold")
	call g:HL("StatuslineFirstError", g:colors.red, g:colors.sidebar, "bold")
endfunction " }}}