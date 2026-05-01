------------------
---- MONITORS ----
------------------

hl.monitor({
	output              = "DP-1",
	mode                = "highres",
	position            = "0x0",
	scale               = "auto",
	bitdepth            = 10,
	cm                  = "auto",
	vrr                 = 3,
	supports_wide_color = 1,
	supports_hdr        = 1,
	sdrbrightness       = 1.15,
	sdrsaturation       = 1.0,
	sdr_min_luminance   = 0.005,
	sdr_max_luminance   = 200,
	min_luminance       = 0,
	max_luminance       = 1000,
	max_avg_luminance   = 200
})

hl.monitor({ output = "DP-2", mode = "1920x1080@60", position = "auto-left", scale = "auto" })


------------------
---- PROGRAMS ----
------------------

local terminal = "kitty"
local fileManager = terminal .. " yazi"
local altFileManager = "thunar"


-------------------
---- AUTOSTART ----
-------------------

hl.on("config.reloaded", function ()
	hl.exec_cmd("pkill waybar || true && waybar")
	hl.exec_cmd("systemctl --user restart awww clipse dunst wlsunset")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("PROTON_ENABLE_HDR", "0")


---------------------
---- PERMISSIONS ----
---------------------

hl.config({
	ecosystem = {
		enforce_permissions = true,
	},
})

hl.permission({ binary = "/nix/store/[a-z0-9]{32}-grim-[0-9.]*/bin/grim", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/nix/store/[a-z0-9]{32}-xdg-desktop-portal-hyprland-[0-9.]*/libexec/.xdg-desktop-portal-hyprland-wrapped", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/nix/store/[a-z0-9]{32}-hyprland-[0-9.]*.*/bin/hyprpm", type = "plugin", mode = "allow"})


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in  = 5,
		gaps_out = 20,

		border_size = 2,
		col = {
			active_border   = { colors = {"rgba(c4a7e7ee)", "rgba(ebbcbaee)"}, angle = 90 },
			inactive_border = "rgba(6e6a86aa)",
		},

		resize_on_border = false,

		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding       = 10,
		rounding_power = 2,

		active_opacity   = 0.99,
		inactive_opacity = 0.97,

		shadow = {
			enabled      = true,
			range        = 4,
			render_power = 3,
			color        = 0xee1a1a1a,
		},

		blur = {
			enabled  = true,
			size     = 3,
			passes   = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})

-- Default curves and animations
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}    } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}  } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

hl.config({
	dwindle = {
		preserve_split = true,
	},
})

hl.config({
	master = {
		new_status = "master",
	},
})

hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})


--------------
---- MISC ----
--------------

hl.config({
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo   = false,
	},
})


---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout  = "us",
		kb_variant = "",
		kb_model   = "",
		kb_options = "",
		kb_rules   = "",

		follow_mouse = 1,

		sensitivity = 0,

		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.gesture({
	fingers   = 3,
	direction = "horizontal",
	action    = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
-- hl.device({
--     name        = "epic-mouse-v1",
--     sensitivity = -0.5,
-- })


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + F4",        hl.dsp.window.kill())
hl.bind(mainMod .. " + period",    hl.dsp.window.signal({ signal = 19 }))
hl.bind(mainMod .. " + comma",     hl.dsp.window.signal({ signal = 18 }))
hl.bind(mainMod .. " + M",         hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()"))
hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(altFileManager))
hl.bind(mainMod .. " + W",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P",         hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J",         hl.dsp.layout("togglesplit"))

for _,key in ipairs({"left", "right", "up", "down"}) do
	hl.bind(mainMod .. " + " .. key,                hl.dsp.focus({ direction = key }))
	hl.bind(mainMod .. " + SHIFT + " .. key,        hl.dsp.window.move({ direction = key}))
	hl.bind(mainMod .. " + CTRL + SHIFT + " .. key, hl.dsp.window.swap({ direction = key }))
end

for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i}))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.bind(mainMod .. " + SHIFT + F11", hl.dsp.window.fullscreen())

hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("pkill -x rofi || rofi -show drun -disable-history -show-icons -config $HOME/.config/rofi/app-launcher.rasi"))

hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd("librewolf"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("librewolf -P school"))
hl.bind(mainMod .. " + R",         hl.dsp.exec_cmd(terminal .. " hx"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("pkill -x rofi || rofi -show calc -modi calc -no-show-match -no-sort -no-history -lines 0 -terse -config '.config/rofi/calculator.rasi' -hint-welcome '' -hint-result '' -kb-accept-entry ''"))
hl.bind("CTRL + SHIFT + Escape",   hl.dsp.exec_cmd(terminal .. " btop"))

hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(terminal .. " --class clipse -e clipse"))

hl.bind("Print", hl.dsp.exec_cmd("grim - | wl-copy"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd([[hyprctl -j activewindow | jq -r '"(.at[0]),(.at[1]) (.size[0])x(.size[1])"' | grim -g - - | wl-copy]]))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("slurp | grim -g - - | wl-copy"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("grim - | swappy -f -"))
hl.bind("CTRL + ALT + Print", hl.dsp.exec_cmd([[hyprctl -j activewindow | jq -r '"(.at[0]),(.at[1]) (.size[0])x(.size[1])"' | grim -g - - | swappy -f -]]))
hl.bind("SHIFT + ALT + Print", hl.dsp.exec_cmd("slurp | grim -g - - | swappy -f -"))

hl.bind("Control_R + Alt_R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + ALT + G", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/gamemode.sh"))


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps.
	name  = "suppress-maximize-events",
  match = { class = ".*" },

  suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
  -- Fix some dragging issues with XWayland
  name  = "fix-xwayland-drags",
  match = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})

hl.window_rule({
	name = "clipse-window",
	match = { class = "clipse" },

	float = true,
	size = "622 652",
	stay_focused = true 
})

hl.window_rule({
	name = "fcitx-windows",
	match = { class = "fcitx5" },

	pseudo = true,
})
