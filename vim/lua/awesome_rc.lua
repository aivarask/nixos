pcall(require, 'luarocks.loader')
-- https://github.com/atsepkov/awesome-awesome-wm

gears = require('gears') -- https://awesomewm.org/apidoc/core_components/gears.timer.html
awful = require('awful') -- https://awesomewm.org/apidoc/core_components/awful.keygrabber.html
require('awful.autofocus')
wibox = require('wibox') -- https://awesomewm.org/apidoc/widget_layouts/wibox.layout.align.html
beautiful = require('beautiful') -- https://awesomewm.org/apidoc/theme_related_libraries/beautiful.html
naughty = require('naughty') -- Notification library
menubar = require('menubar')
hotkeys_popup = require('awful.hotkeys_popup') -- Enable hotkeys help widget for VIM and other apps when client with a matching name is opened:
require('awful.hotkeys_popup.keys')

-- https://vicious.readthedocs.io/en/latest/examples.html#
vicious = require('vicious')

aiva = require('aiva')

require('error')
require('variables')
require('menu')
require('bar')
require('keymaps')
require('rules')
require('signals')

