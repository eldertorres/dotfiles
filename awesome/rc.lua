-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- Miscellanous awesome library
local menubar = require("menubar")

RC = {} -- global namespace, on top before require any modules
RC.vars = require("main.user-variables")()
modkey = RC.vars.modkey

-- Error handling
require("main.error-handling")

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.wallpaper = RC.vars.wallpaper

-- Set gaps
beautiful.useless_gap = 3

-- Custom Local Library
local main = {
    layouts = require("main.layouts"),
    tags    = require("main.tags"),
    menu    = require("main.menu"),
    rules   = require("main.rules"),
}

local binding = {
    globalbuttons = require("binding.globalbuttons"),
    clientbuttons = require("binding.clientbuttons"),
    globalkeys    = require("binding.globalkeys"),
    clientkeys    = require("binding.clientkeys"),
    bindtotags    = require("binding.bindtotags")
}

-- {{{ Layouts
-- Table of layouts to cover with awful.layout.inc, order matters.
-- a variable needed in main.tags, and statusbar
-- awful.layout.layouts = { ... }
RC.layouts = main.layouts()
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
-- a variable needed in rules, tasklist, and globalkeys
RC.tags = main.tags()
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
RC.mainmenu = awful.menu({ items = main.menu() }) -- in globalkeys

-- a variable needed in statusbar (helper)
RC.launcher = awful.widget.launcher(
  { image = beautiful.awesome_icon, menu = RC.mainmenu }
)

-- Menubar configuration
-- Set the terminal for applications that require it
menubar.utils.terminal = RC.vars.terminal

-- }}}

-- {{{ Mouse and Key bindings
RC.globalkeys = binding.globalkeys()
RC.globalkeys = binding.bindtotags(RC.globalkeys)

-- Set root
root.buttons(binding.globalbuttons())
root.keys(RC.globalkeys)
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Statusbar: Wibar
require("deco.statusbar")
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = main.rules(
  binding.clientkeys(),
  binding.clientbuttons()
)
-- }}}

-- {{{ Signals
require("main.signals")
-- }}}


-- {{{ Customizations
require("awful.autofocus")

-- Notification library
local naughty = require("naughty")


-- Configurações do Naughty - notifications
naughty.config.defaults = {
    ontop          = true,
    timeout        = 8,
    title          = "Notificação",
    margin         = 15,
    position       = "top_right",
    border_width   = 1,
    border_color   = "#ff00ff",
    shape          = gears.shape.rounded_rect,
    font           = "Monofur Nerd Font 12",
    bg             = "#0d0d0dcc",
    fg             = "#00ffff",
    icon_size      = 64,
    max_width      = 450,
    max_height     = 160,
    hover_timeout  = nil,
}

-- Cores por nível de urgência
naughty.config.presets.low = {
    font          = "Monofur Nerd Font 12",
    fg            = "#00ff9f",
    bg            = "#1e001ecc",
    border_color  = "#00ff9f",
    timeout       = 6,
}

naughty.config.presets.normal = {
    font          = "Monofur Nerd Font 12",
    fg            = "#00ffff",
    bg            = "#1e001ecc",
    border_color  = "#00ffff",
    timeout       = 8,
}

naughty.config.presets.critical = {
    font          = "Monofur Nerd Font 12",
    fg            = "#ff073a",
    bg            = "#3a0000cc",
    border_color  = "#ff073a",
    timeout       = 0,
}

-- }}}
-- Autostart Applications
awful.spawn.with_shell("~/.config/awesome/scripts/autostart.sh")
