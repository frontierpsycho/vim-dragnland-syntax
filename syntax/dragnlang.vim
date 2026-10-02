" Vim syntax file
" Language:	DragnLang
" Maintainer:	FrontierPsycho
" Last Change:	2026-10-02
" Version:	0.1

if !exists("main_syntax")
  " quit when a syntax file was already loaded
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'dragnlang'
endif

syntax match   jsonNoise           /\%(:\|,\)/

" NOTE that for the concealing to work your conceallevel should be set to 2

" Syntax: JSON Keywords
" Separated into a match and region because a region by itself is always greedy
syn match  jsonKeywordMatch /"\([^"]\|\\\"\)\+"[[:blank:]\r\n]*\:/ contains=jsonKeyword
if has('conceal') && (!exists("g:vim_json_conceal") || g:vim_json_conceal==1)
   syn region  jsonKeyword matchgroup=jsonQuote start=/"/  end=/"\ze[[:blank:]\r\n]*\:/ concealends contained
else
   syn region  jsonKeyword matchgroup=jsonQuote start=/"/  end=/"\ze[[:blank:]\r\n]*\:/ contained
endif

" Syntax: Strings
" Separated into a match and region because a region by itself is always greedy
" Needs to come after keywords or else a json encoded string will break the
" syntax
syn match  jsonStringMatch /"\([^"]\|\\\"\)\+"\ze[[:blank:]\r\n]*[,}\]]/ contains=jsonString
if has('conceal') && (!exists("g:vim_json_conceal") || g:vim_json_conceal==1)
	syn region  jsonString oneline matchgroup=jsonQuote start=/"/  skip=/\\\\\|\\"/  end=/"/ concealends contains=jsonEscape,dragnlangBuiltInFunction,dragnlangVariable contained
else
	syn region  jsonString oneline matchgroup=jsonQuote start=/"/  skip=/\\\\\|\\"/  end=/"/ contains=jsonEscape,dragnlangBuiltInFunction,dragnlangVariable contained
endif

" Syntax: JSON does not allow strings with single quotes, unlike JavaScript.
syn region  jsonStringSQError oneline  start=+'+  skip=+\\\\\|\\"+  end=+'+


" Syntax: Escape sequences
syn match   jsonEscape    "\\["\\/bfnrt]" contained
syn match   jsonEscape    "\\u\x\{4}" contained

" Syntax: Numbers
syn match   jsonNumber    "-\=\<\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([eE][-+]\=\d\+\)\=\>\ze[[:blank:]\r\n]*[,}\]]"

" Syntax: DragnLang Built-in functions (incomplete)
syn keyword dragnlangBuiltInFunction contained ABILITY
			\ ABORT
			\ ACTION_LIST
			\ ADD
			\ ADD_TEMP_TOKEN
			\ ADVANCE_TO_STEP
			\ AND
			\ APPEND
			\ ATTACH_CARD
			\ AT_INDEX
			\ BASE64_DECODE
			\ BASE64_ENCODE
			\ CALC
			\ CHOOSE_N
			\ CONCAT_LISTS
			\ COND
			\ CURRENT_TIME
			\ DECREASE_VAL
			\ DECREASE_VAR
			\ DEFINE
			\ DEFINED
			\ DELETE_CARD
			\ DIVIDE
			\ DRAW_CARD
			\ EQUAL
			\ ERROR
			\ EXTRACT_TAG
			\ FACEUP_NAME_FROM_CARD_ID
			\ FACEUP_NAME_FROM_STACK_ID
			\ FADE_TEXT_CARD
			\ FADE_TEXT_GAME
			\ FADE_TEXT_PLAYER
			\ FALSE
			\ FILTER_CARDS
			\ FORMAT
			\ FOR_EACH_KEY_VAL
			\ FOR_EACH_START_STOP_STEP
			\ FOR_EACH_VAL
			\ FUNCTION
			\ GET
			\ GET_ALIAS
			\ GET_CARD
			\ GET_CARD_ID
			\ GET_INDEX
			\ GET_LOAD_LIST
			\ GET_STACK_ID
			\ GREATER_EQUAL
			\ GREATER_THAN
			\ GROUP_EMPTY
			\ GROUP_NOT_EMPTY
			\ INCREASE_VAL
			\ INCREASE_VAR
			\ INDEX_OF
			\ INSPECT
			\ INSPECT_INT
			\ IN_LIST
			\ IN_STRING
			\ JOIN_LIST
			\ JOIN_STRING
			\ LABEL
			\ LANGUAGE
			\ LENGTH
			\ LESS_EQUAL
			\ LESS_THAN
			\ LIST
			\ LIST_DELETE_AT
			\ LIST_INSERT_AT
			\ LIST_REPLACE_AT
			\ LOAD_CARDS
			\ LOG
			\ LOGF
			\ LOG_DEV
			\ LOOK_AT
			\ MAP
			\ MAP_DELETE
			\ MAP_GET
			\ MAP_HAS_KEY
			\ MAP_KEYS_TO_LIST
			\ MAP_PUT
			\ MAP_SET
			\ MAP_SET_DELETE
			\ MAP_SET_HAS
			\ MAP_SET_PUT
			\ MAP_SET_TO_LIST
			\ MAP_VALUES_TO_LIST
			\ MAX
			\ MIN
			\ MODULO
			\ MOVE_CARD
			\ MOVE_STACK
			\ MOVE_STACKS
			\ MULTIPLY
			\ MULTI_VAR
			\ MULTI_VAR_NO_EVAL
			\ NEXT_PLAYER
			\ NEXT_STEP
			\ NOT
			\ NOT_EQUAL
			\ OBJ_GET_BY_PATH
			\ OBJ_GET_VAL
			\ OBJ_SET_VAL
			\ ONE_CARD
			\ ONE_CARD_WITH_FACE_KEY_VAL
			\ OR
			\ PLURAL_INDEX
			\ POINTER
			\ PREV
			\ PREV_STEP
			\ PROCESS_MAP
			\ PROMPT
			\ PROMPT_ADD_OPTION
			\ RANDOM_INT
			\ REGEX_REPLACE
			\ REMOVE_ALL_TEMP_TOKENS
			\ REMOVE_FIRST_FROM_LIST_BY_VALUE
			\ REMOVE_FROM_LIST_BY_VALUE
			\ REPLACE_STRING_IN_LIST
			\ REQUEST_HTML
			\ REQUEST_JSON
			\ REQUEST_POST
			\ RESET_GAME
			\ RESET_INDEX
			\ REVERSE_LIST
			\ ROUND_TO_INT
			\ SAVE_GAME
			\ SELECT_CARDS
			\ SET
			\ SET_LAYOUT
			\ SHUFFLE_BOTTOM_X
			\ SHUFFLE_GROUP
			\ SHUFFLE_LIST
			\ SHUFFLE_TOP_X
			\ SORT_OBJ_LIST
			\ SPLIT_STRING
			\ STOP_LOOKING
			\ STRING_TO_OBJ
			\ SUBSTRING
			\ SUBTRACT
			\ TARGET
			\ TARGET_PLAYER_I
			\ TIME_IT
			\ TO_INT
			\ TO_LOWERCASE
			\ TO_UPPERCASE
			\ TRUE
			\ TYPE_OF
			\ UNLOAD_CARDS
			\ UNSET
			\ UPDATE_LAYOUT
			\ UPDATE_VAR
			\ VAR
			\ WHILE

" Syntax: DragnLang variables
syn match dragnlangVariable	/\$\w\+/ contained

" ERROR WARNINGS **********************************************
if (!exists("g:vim_json_warnings") || g:vim_json_warnings==1)
	" Syntax: Strings should always be enclosed with quotes.
	syn match   jsonNoQuotesError  "\<[[:alpha:]][[:alnum:]]*\>"
	syn match   jsonTripleQuotesError  /"""/

	" Syntax: An integer part of 0 followed by other digits is not allowed.
	syn match   jsonNumError  "-\=\<0\d\.\d*\>"

	" Syntax: Decimals smaller than one should begin with 0 (so .1 should be 0.1).
	syn match   jsonNumError  "\:\@<=[[:blank:]\r\n]*\zs\.\d\+"

	" Syntax: No comments in JSON, see http://stackoverflow.com/questions/244777/can-i-comment-a-json-file
	syn match   jsonCommentError  "//.*"
	syn match   jsonCommentError  "\(/\*\)\|\(\*/\)"

	" Syntax: No semicolons in JSON
	syn match   jsonSemicolonError  ";"

	" Syntax: No trailing comma after the last element of arrays or objects
	syn match   jsonTrailingCommaError  ",\_s*[}\]]"

	" Syntax: Watch out for missing commas between elements
	syn match   jsonMissingCommaError /\("\|\]\|\d\)\zs\_s\+\ze"/
	syn match   jsonMissingCommaError /\(\]\|\}\)\_s\+\ze"/ "arrays/objects as values
	syn match   jsonMissingCommaError /}\_s\+\ze{/ "objects as elements in an array
	syn match   jsonMissingCommaError /\(true\|false\)\_s\+\ze"/ "true/false as value
endif

" ********************************************** END OF ERROR WARNINGS
" Allowances for JSONP: function call at the beginning of the file,
" parenthesis and semicolon at the end.
" Function name validation based on
" http://stackoverflow.com/questions/2008279/validate-a-javascript-function-name/2008444#2008444
syn match  jsonPadding "\%^[[:blank:]\r\n]*[_$[:alpha:]][_$[:alnum:]]*[[:blank:]\r\n]*("
syn match  jsonPadding ");[[:blank:]\r\n]*\%$"

" Syntax: Boolean
syn match  jsonBoolean /\(true\|false\)\(\_s\+\ze"\)\@!/

" Syntax: Null
syn keyword  jsonNull      null

" Syntax: Braces
syn region  jsonFold matchgroup=jsonBraces start="{" end=/}\(\_s\+\ze\("\|{\)\)\@!/ transparent fold
syn region  jsonFold matchgroup=jsonBraces start="\[" end=/]\(\_s\+\ze"\)\@!/ transparent fold

" Define the default highlighting.
" Only when an item doesn't have highlighting yet
hi def link jsonPadding			Operator
hi def link jsonString			String
hi def link jsonTest			Label
hi def link jsonEscape			Special
hi def link jsonNumber			Number
hi def link jsonBraces			Delimiter
hi def link jsonNull			Function
hi def link jsonBoolean			Boolean
hi def link jsonKeyword			Label
hi def link dragnlangBuiltInFunction	Function
hi def link dragnlangVariable		Constant

if (!exists("g:vim_json_warnings") || g:vim_json_warnings==1)
hi def link jsonNumError        Error
hi def link jsonCommentError    Error
hi def link jsonSemicolonError  Error
hi def link jsonTrailingCommaError     Error
hi def link jsonMissingCommaError      Error
hi def link jsonStringSQError        	Error
hi def link jsonNoQuotesError        	Error
hi def link jsonTripleQuotesError     	Error
endif
hi def link jsonQuote           Quote
hi def link jsonNoise           Noise

let b:current_syntax = "dragnlang"
if main_syntax == 'dragnlang'
  unlet main_syntax
endif

" Vim settings
" vim: ts=8 fdm=marker
