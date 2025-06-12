local M = {}

M.modifiers = {"alt"}

function M:bindKeys()
  hs.hotkey.bind(M.modifiers, "s", function()
    hs.application.launchOrFocus("Spotify")
  end)
  hs.hotkey.bind(M.modifiers, "t", function()
    hs.application.launchOrFocus("kitty")
  end)
  hs.hotkey.bind(M.modifiers, "b", function()
    hs.application.launchOrFocus("Safari")
  end)
  hs.hotkey.bind(M.modifiers, "m", function()
    hs.application.launchOrFocus("Mail")
  end)
  hs.hotkey.bind(M.modifiers, "f", function()
    hs.application.launchOrFocus("Finder")
  end)
  hs.hotkey.bind(M.modifiers, "n", function()
    hs.application.launchOrFocus("Notes")
  end)
  hs.hotkey.bind(M.modifiers, "w", function()
    hs.application.launchOrFocus("Whatsapp")
  end)
end

return M
