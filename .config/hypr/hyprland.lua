-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
local home = os.getenv("HOME")

-- my custom binaries
hl.env("PATH", home .. "/bin:" .. home .. "/.local/bin:/usr/bin:/bin:/usr/local/bin")

-- Mozilla
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- Set the cursor size for xcursor
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Ozone
hl.env("OZONE_PLATFORM", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

------------------
---- MONITORS ----
------------------
hl.monitor({ output = "eDP-1", mode = "highres", position = "auto-right", scale = 1, transform = 0 })
hl.monitor({ output = "HDMI-A-1", mode = "highres", position = "0x0", scale = 1 })

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
	hl.exec_cmd("noctalia")

	-- Start network manager applet: very important
	hl.exec_cmd("nm-applet --indicator")

	-- Start blueman (bluetooth manager)
	hl.exec_cmd("blueman-applet")

	-- Load cliphist history
	hl.exec_cmd("wl-paste --watch cliphist store")
end)

---------------
---- INPUT ----
---------------
hl.config({
	input = {
		kb_layout = "halmak_no_qwerty, us, ara",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:shifts_toggle",
		numlock_by_default = true,
		mouse_refocus = false,

		follow_mouse = 1,
		touchpad = {
			-- for desktop
			-- natural_scroll = false,

			-- for laptop
			natural_scroll = true,
			middle_button_emulation = true,
			clickfinger_behavior = false,
			scroll_factor = 1.5, -- Touchpad scroll factor
			disable_while_typing = true,
		},
		sensitivity = 0, -- Pointer speed: -1.0 - 1.0, 0 means no modification.
	},
})

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,

		border_size = 4,

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = true,

		-- Please see https://wiki.hypr.land/configuring/extra/tearing/ before you turn this on
		allow_tearing = false,

		layout = "scrolling",
	},

	gestures = {
		workspace_swipe_touch = true,
	},

	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
		focus_on_activate = true, -- Whether Hyprland should focus an app that requests to be focused
	},

	debug = {
		vfr = true,
	},
})

hl.config({
	decoration = {
		rounding = 20,
		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		blur = {
			enabled = false,
		},

		shadow = {
			enabled = false,
		},
	},
})

-- require("modules.decorations.aestheticBlur")

----------------------
---- ANIMATIONS ----
----------------------
hl.config({ animations = { enabled = true } })

-- Curves
hl.curve("md3_decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("md3_accel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })

-- Windows
hl.animation({ leaf = "windows", enabled = true, speed = 2, bezier = "md3_decel", style = "popin 80%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2, bezier = "md3_decel", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "md3_accel", style = "popin 80%" })

-- Border and fade
hl.animation({ leaf = "border", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 2, bezier = "md3_decel" })

-- Layers
hl.animation({ leaf = "layersIn", enabled = true, speed = 2, bezier = "md3_decel", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "md3_accel" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.5, bezier = "md3_decel" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 2, bezier = "md3_accel" })

-- Workspaces
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "md3_decel", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 2, bezier = "md3_decel", style = "slidevert" })

---------------
---- LAYOUT ----
---------------
-- See https://wiki.hypr.land/configuring/layouts/master-layout/ for more
hl.config({
	master = {
		new_status = "master",
	},
})

-- See https://wiki.hypr.land/configuring/layouts/scrolling-layout/ for more
hl.config({
	scrolling = {
		column_width = 0.6,
		fullscreen_on_one_column = true,
		follow_focus = true,
		focus_fit_method = 1,
	},
})

---------------------
---- KEYBINDINGS ----
---------------------
-- See https://wiki.hypr.land/configuring/core/binds/

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local hyprScripts = "~/.config/hypr/scripts"

-- [_____ Windows _____]
hl.bind(mainMod .. " + W", hl.dsp.window.close()) -- kill active window
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill")) -- Quit active window and all open instances

-- panic button, turn on internal dispaly (eDP-1)
hl.bind(
	mainMod .. " + SHIFT + J",
	hl.dsp.exec_cmd("hyprctl eval 'hl.monitor({ output = \"eDP-1\", disabled = false })'")
)

-- window navigation using right hand home-row
hl.bind(mainMod .. " + A", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + E", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + O", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + I", hl.dsp.focus({ direction = "right" }))

-- window resize using right hand home-row
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.resize({ x = -100, y = 0, relative = true })) -- Reduce window width
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.window.resize({ x = 0, y = 100, relative = true })) -- Increase window height
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.window.resize({ x = 0, y = -100, relative = true })) -- Reduce window height
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.window.resize({ x = 100, y = 0, relative = true })) -- Increase window width

-- toggle fullscreen and floating
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + Z", hl.dsp.window.float({ action = "toggle" })) -- Toggle active window into floating mode

hl.bind(mainMod .. " + SHIFT + z", hl.dsp.layout("consume"))

-- swap window using right hand home-row
hl.bind(mainMod .. " + ALT + A", hl.dsp.window.swap({ direction = "left" })) -- Swap tiled window left
hl.bind(mainMod .. " + ALT + E", hl.dsp.window.swap({ direction = "down" })) -- Swap tiled window down
hl.bind(mainMod .. " + ALT + O", hl.dsp.window.swap({ direction = "up" })) -- Swap tiled window up
hl.bind(mainMod .. " + ALT + I", hl.dsp.window.swap({ direction = "right" })) -- Swap tiled window right

-- swap column (scrolling layout)
hl.bind(mainMod .. " + K", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + Y", hl.dsp.layout("swapcol r"))

-- window navigation using ALT TAB (was binde: repeats while held)
hl.bind("ALT + Tab", function()
	hl.dispatch(hl.dsp.window.cycle_next()) -- Cycle between windows
	hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" })) -- Bring active window to the top
end, { repeating = true })

-- [____ Noctalia shell ____]
local ipc = "noctalia msg "

hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd(ipc .. "panel-toggle wallpaper"))
hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher /emo"))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(ipc .. "panel-toggle clipboard")) -- Open clipboard manager
hl.bind("XF86RFKill", hl.dsp.exec_cmd(ipc .. "lockScreen lock")) -- Map airplane mode button to lock screen
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd(ipc .. "lockScreen lock")) -- (same key as resize above; both fire, as before)
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(ipc .. "sessionMenu toggle")) -- session menu AKA power menu Mod+Shift+P (M in qwerty)

-- [_____ Actions _____]
-- hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("~/.config/waybar/launch.sh"))
hl.bind(
	mainMod .. " + H",
	hl.dsp.exec_cmd([[grim - | tee ~/Pictures/Screenshots/snapshot_$(date +'%Y-%m-%d_%H-%M-%S').png | wl-copy]])
)
hl.bind(
	mainMod .. " + SHIFT + H",
	hl.dsp.exec_cmd(
		[[grim -g "$(slurp -d -p)" - | tee ~/Pictures/Screenshots/snapshot_$(date +'%Y-%m-%d_%H-%M-%S').png | wl-copy]]
	)
)
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload")) -- Reload Hyprland configuration

-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(hyprScripts .. "/screenshot.sh")) -- Take a screenshot
-- TODO: cycle between external monitor profiles using mainMod + J (P in qwerty)

-- [_____ Applications _____]
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty")) -- TODO: try using the terminal variable

-- [_____ Mouse bindings _____]
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- Move window with the mouse
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- Resize window with the mouse

-- [_____ Workspaces _____]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i })) -- Open workspace i
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i })) -- Move active window to workspace i
	hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.exec_cmd(hyprScripts .. "/moveTo.sh " .. i)) -- Move all windows to workspace i
end

hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "m+1" })) -- Open next workspace
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" })) -- Open previous workspace

hl.bind(mainMod .. " + CTRL + down", hl.dsp.focus({ workspace = "empty" })) -- Open the next empty workspace

-- [_____ Special Workspace _____]
-- mapping it to M (X in qwerty)
hl.bind(mainMod .. " + M", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.window.move({ workspace = "special:magic" }))

-- [_____ Fn keys _____]
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -q s +1%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -q s 1%-"))
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ +5%")
) -- Increase volume by 5%
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ -5%")
) -- Reduce volume by 5%
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle")) -- Toggle mute
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause")) -- Audio play pause
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause")) -- Audio pause
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next")) -- Audio next
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous")) -- Audio previous
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle")) -- Toggle microphone
hl.bind("XF86Calculator", hl.dsp.exec_cmd("~/.config/ml4w/settings/calculator.sh")) -- Open calculator

hl.bind("code:238", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s +10"))
hl.bind("code:237", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s 10-"))

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
-- See https://wiki.hypr.land/configuring/core/rules/

hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

-- Pavucontrol floating
hl.window_rule({
	name = "floating-pulseaudio-app",
	match = { class = ".*org.pulseaudio.pavucontrol.*" },

	float = true,
})

hl.window_rule({
	name = "floating-emoji-picker",
	match = { class = ".*org.gnome.Characters.*" },

	float = true,
	pin = true,
})

hl.window_rule({
	name = "floating-localsend",
	match = { class = "localsend" },

	float = true,
	pin = true,
})

hl.window_rule({
	name = "floating-calculator",
	match = { class = ".*org.gnome.Calculator.*" },

	float = true,
	size = "700 600",
})

--! IMPORTANT
hl.window_rule({
	name = "rider-popups-fix",
	match = {
		class = "jetbrains-rider",
		title = "^win(.*)",
		float = true,
	},

	no_focus = true,
	no_initial_focus = true,
})

hl.window_rule({
	name = "google-signin-float",
	match = {
		class = "brave-browser",
		title = ".*Sign in – Google accounts.*",
	},

	float = true,
	pin = true,
})

-- hl.window_rule({
-- 	name = "thunar-progress-popup",
-- 	match = {
-- 		class = "thunar",
-- 		title = "File Operation Progress",
-- 	},
--
-- 	float = true,
-- })

hl.window_rule({
	name = "thunar-popups",
	match = {
		class = "^(thunar|Thunar)$",
		title = "^(File Operation Progress|Confirm to replace files|Rename.*|Create New (Folder|File)|.* - Properties|File Manager Preferences|Bulk Rename.*|Open With.*|Error|Attention|Question|Confirm.*)$",
	},

	float = true,
	center = true,
})

hl.window_rule({
	name = "floating-blueman-manager",
	match = { class = "blueman-manager" },

	float = true,
})

hl.layer_rule({
	name = "noctalia",
	match = { namespace = "noctalia-background-.*$" },

	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})

-----------------------------
---- NOCTALIA COLORS ----
-----------------------------
require("noctalia").apply_theme()
