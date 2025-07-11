local appLauncher = require('appLauncher')
appLauncher.bindKeys()

----
-- A tab chooser for Safari written with AppleScript (yikes) and HammerSpoon
----

----
-- Known issues:

-- If a tab has double quotes, unsure about what will happen, the tab
-- list creation is brittle. Single quote is fixed though

-- It was a very quick and dirty hack to try HammerSpoon (cool!) The
-- AppleScript JSON generation can be improved, as well as the
-- tabSwitcher in general. Since now it works, I won't touch it until
-- need arises
----

getTabs = [[
on replaceString(theText, oldString, newString)
	-- From http://applescript.bratis-lover.net/library/string/#replaceString
	local ASTID, theText, oldString, newString, lst
	set ASTID to AppleScript's text item delimiters
	try
		considering case
			set AppleScript's text item delimiters to oldString
			set lst to every text item of theText
			set AppleScript's text item delimiters to newString
			set theText to lst as string
		end considering
		set AppleScript's text item delimiters to ASTID
		return theText
	on error eMsg number eNum
		set AppleScript's text item delimiters to ASTID
		error "Can't replaceString: " & eMsg number eNum
	end try
end replaceString


tell application "Safari"
	set tablist to "{"
	repeat with w in (every window whose visible is true)
		set ok to true
		try
			repeat with t in every tab of w
				set tabName to name of t
				set tabName to my replaceString(tabName, "'", "`")
				set tabId to index of t
				set wId to index of w
				set tablist to tablist & "'" & tabId & "': {'text': '" & tabName & "', 'wid': '" & wId & "'}, "
			end repeat
			set tablist to tablist & "}"
			return tablist
		on error errmsg
			display alert errmsg
			set ok to false
		end try
	end repeat
end tell
]]

function tabChooserCallback(input)
   hs.osascript.applescript("tell window " .. input.wid .. " of application \"Safari\" to set current tab to tab " .. input.id)
   hs.application.launchOrFocus("Safari")
end


function tabSwitcher()
   print(hs.application.frontmostApplication():name())
   if hs.application.frontmostApplication():name() == "Safari" then
      local works, obj, tabs = hs.osascript._osascript(getTabs, "AppleScript")
      local tabs = obj:gsub("'", "\"")
      print(tabs)
      local tabTable = hs.json.decode(tabs)
      local ordered_keys = {}

      for k in pairs(tabTable) do
	 table.insert(ordered_keys, tonumber(k))
      end
      table.sort(ordered_keys)
      local chooserTable = {}
      for i = 1, #ordered_keys do
	 local k, v = ordered_keys[i], tabTable[ tostring(ordered_keys[i]) ]
	 table.insert(chooserTable, {["text"] = v['text'], ["id"] = k, ["wid"] = v['wid']})
      end
      local chooser = hs.chooser.new(tabChooserCallback)
      chooser:choices(chooserTable)
      chooser:show()
   end
end 

-- Emacs style switcher. Uncomment the last line for something maybe
-- more usual

-- k = hs.hotkey.modal.new('ctrl', 'x')
-- k:bind('', 'escape', function() k:exit() end)
-- k:bind('', 'b', nil , tabSwitcher)

hs.hotkey.bind({"cmd", "shift"}, "a", tabSwitcher)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")
