--- @class completion
--- @field autoRequire? boolean Default true. When the input looks like a file name, automatically require the file.
--- @field callSnippet?
--- |'Disable' Only show function name. Default
--- |'Both' Show function name and snippet
--- |'Replace' Only show the call snippet
--- @field displayContext? integer Default 0. When a completion is being suggested, this setting will set the amount of lines around the definition to preview to help you better understand its usage.
--- @field enable? boolean Default true. Enable/disable completion. Completion works like any autocompletion you already know of. It helps you type less and get more done.
--- @field keywordSnippet?
--- |'Disable' Only completes the keyword
--- |'Both' Offers a completion for the keyword and snippet
--- |'Replace' Only shows a snippet. Default
--- @field postfix? string Default @. The character to use for triggering a "postfix suggestion". A postfix allows you to write some code and then trigger a snippet after (post) to "fix" the code you have written. This can save some time as instead of typing table.insert(myTable, ), you can just type myTable@.
--- @field requireSeparator? string Default '.'. The separator to use when require-ing a file.
--- @field showParams? boolean Default true. Display a function's parameters in the list of completions. When a function has multiple definitions, they will be displayed separately.
--- @field showWord?
---|'Enable' Always show contextual words in completion suggestions
---|'Fallback' Only show contextual words when smart suggestions based on semantics cannot be provided. Defaul
---|'Disable' Never show contextual words
---@field workspaceWord? boolean Default true. Whether words from other files in the workspace should be suggested as "contextual words". This can be useful for completing similar strings. completion.showWord must not be disabled for this to have an effect.

--- @alias arrayIndex
---|'Enable' Show hint in all tables
---|'Auto' If more than 3 items or the table is mixed (indexes and keys). Default
---|'Disable' Disable array index hints

--- @class hint
--- @field arrayIndex? arrayIndex Default 'Auto'
--- @field await? boolean Default true. If a function has been defined as @async, display an await hint when it is being called.
--- @field enable? boolean Default false. Whether inline hints should be enabled or not.

--- @class workspace
--- @field checkThirdParty?
--- |'Ask' (ask every time)
--- |'Apply' (always apply automatically)
--- |'ApplyInMemory' (always apply definition files, but don't apply setting)
--- |'Disable' (Don't ask, don't apply)
--- |false
--- @field maxPreload? integer Default 5000. The maximum amount of files that can be diagnosed. More files will require more RAM.
--- @field preloadFileSize? integer Default 500. Files larger than this value (in KB) will be skipped when loading for workspace diagnosis.

--- @class diagnostics https://luals.github.io/wiki/settings/#diagnostics
--- @field disable? table Disable certain diagnostics globally.

--- @class LuaSettings
--- @field completion? completion @see https://luals.github.io/wiki/settings/
--- @field diagnostics? diagnostics
--- @field hint? hint
--- @field workspace? workspace

--- @type LuaSettings
---@diagnostic disable-next-line: unused-local
local settings = {
	diagnostics = {
		disable = {
			'lowercase-global',
		},
	},
}
