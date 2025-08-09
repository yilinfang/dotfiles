-- Define your modifier keys in one place for easy changing
local mods = {"cmd", "alt", "shift", "ctrl"}  -- Change this line to modify all shortcuts at once

-- General Shortcuts for Applications
local appShortcuts = {
    -- Key, Application
    {"F", "Finder"},
    {"E", "Brave Browser"},
    {"P", "Bitwarden"},
    {"W", "WeChat"},
--    {"N", "Joplin"},
--    {"C", "Visual Studio Code"},
--    {"A", "Antinote"},
--    {"M", "Monica"},
}

-- General Shortcuts for Links
local linkShortcuts = {
    -- Key, Description, URL
--   {"D", "DeepSeek", "https://chat.deepseek.com/"},
    {"N", "Notion", "https://www.notion.so/"},
    {"M", "Monica", "https://monica.im/"},
--    {"G", "Gemini", "https://gemini.google.com/"},
}

-- Function to display notification and open an application
local function notifyAndLaunchApp(appName)
    local success = hs.application.launchOrFocus(appName)
    if success then
        hs.notify.new({title = "Hammerspoon", informativeText = "Launched " .. appName}):send()
    else
        hs.notify.new({title = "Hammerspoon", informativeText = "Failed to launch " .. appName}):send()
    end
end

-- Function to display notification and open a URL
local function notifyAndOpenURL(description, url)
    hs.notify.new({title = "Hammerspoon", informativeText = "Opening " .. description}):send()
    hs.urlevent.openURL(url)
end

-- Create shortcuts for each application
for _, app in ipairs(appShortcuts) do
    hs.hotkey.bind(mods, app[1], function()
        notifyAndLaunchApp(app[2])
    end)
end

-- Create shortcuts for each link
for _, link in ipairs(linkShortcuts) do
    hs.hotkey.bind(mods, link[1], function()
        notifyAndOpenURL(link[2], link[3])
    end)
end

-- Other Shortcuts
-- Bind mods+T to OpenInTerminal-Lite in Finder and Terminal Emulator elsewhere
hs.hotkey.bind(mods, "T", function()
    -- Check if Finder is the focused application
    local frontApp = hs.application.frontmostApplication()
    if frontApp:name() == "Finder" then
        notifyAndLaunchApp("OpenInTerminal-Lite")
    else
        notifyAndLaunchApp("Ghostty")
    end
end)
