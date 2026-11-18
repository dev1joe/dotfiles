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

-- Old: workspaceopt allfloat (toggle all windows on the workspace into floating mode).
-- There's no workspaceopt dispatcher in the Lua API, so this toggles float on every
-- window of the active workspace instead.
-- hl.bind(mainMod .. " + SHIFT + Z", function()
-- 	local ws = hl.get_active_workspace()
-- 	if ws == nil then
-- 		return
-- 	end
-- 	for _, w in ipairs(hl.get_workspace_windows(ws)) do
-- 		hl.dispatch(hl.dsp.window.float({ action = "toggle", window = "address:" .. w.address }))
-- 	end
-- end)

-- swap window using right hand home-row
hl.bind(mainMod .. " + ALT + A", hl.dsp.window.swap({ direction = "left" })) -- Swap tiled window left
hl.bind(mainMod .. " + ALT + E", hl.dsp.window.swap({ direction = "down" })) -- Swap tiled window down
hl.bind(mainMod .. " + ALT + O", hl.dsp.window.swap({ direction = "up" })) -- Swap tiled window up
hl.bind(mainMod .. " + ALT + I", hl.dsp.window.swap({ direction = "right" })) -- Swap tiled window right

-- toggle window split direction (dwindle layout)
-- hl.bind(mainMod .. " + K", hl.dsp.layout("togglesplit"))

-- swap window split (dwindle layout)
-- hl.bind(mainMod .. " + Y", hl.dsp.layout("swapsplit"))

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

-- [_____ Custom _____]
-- hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("../scripts/cycle_audio_output.sh"))
