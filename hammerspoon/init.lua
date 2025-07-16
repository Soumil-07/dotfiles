hs.loadSpoon("AppLauncher")

spoon.AppLauncher:bindKeys({
    b = "Safari",
    d = "Discord",
    f = "Finder",
    n = "Notes",
    t = "Kitty",
    w = "Whatsapp",
    m = "Mail",
    s = "Spotify"
})

hs.loadSpoon("AClock")
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "C", function()
    spoon.AClock:toggleShow()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
    hs.reload()
end)
hs.alert.show("Config loaded")
