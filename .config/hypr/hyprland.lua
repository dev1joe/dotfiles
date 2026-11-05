-- -----------------------------------------------------------------------------
-- hyprland.lua
-- Single-file conversion of the old hyprlang setup (hyprland.conf + modules/*).
-- Docs: https://wiki.hypr.land/configuring/
--
-- Switch profiles with the three variables below (the old "source = ..." lines).
-- -----------------------------------------------------------------------------

local monitor_profile   = "extend-right" -- "extend-right" | "external-only" | "home"
local input_profile     = "halmak"       -- "halmak" | "us"
local animation_profile = "optimized"    -- "optimized" | "default" | "new"


---------------------
---- MY PROGRAMS ----
---------------------

local mainMod     = "SUPER" -- Sets "Windows" key as main modifier
local hyprScripts = "~/.config/hypr/scripts"

local terminal    = "kitty"
local fileManager = "nautilus"
local menu        = "hyprlauncher"

local home = os.getenv("HOME")


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/configuring/core/environment-variables/

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

-- See https://wiki.hypr.land/configuring/core/monitors/
local monitor_profiles = {
    ["extend-right"] = {
        { output = "HDMI-A-1", mode = "1920x1080", position = "0x0",        scale = 1 },
        { output = "eDP-1",    mode = "1920x1080", position = "auto-right", scale = 1, transform = 0 },
        -- { output = "eDP-1", disabled = true },
    },
    ["external-only"] = {
        { output = "HDMI-A-1", mode = "highres", position = "0x0", scale = 1 },
        { output = "eDP-1",    disabled = true },
    },
    ["home"] = {
        -- [___ 1366x768 monitor ___]
        { output = "eDP-1",    mode = "1920x1080", position = "1600x0", scale = 1, transform = 0 },
        { output = "HDMI-A-1", mode = "1600x900",  position = "0x0",    scale = 1 }, -- can also try 1440x810
    },
}

for _, m in ipairs(monitor_profiles[monitor_profile]) do
    hl.monitor(m)
end


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/configuring/core/autostart/
hl.on("hyprland.start", function()
    -- Start Status bar
    -- hl.exec_cmd("~/.config/waybar/launch.sh")
    -- hl.exec_cmd("sleep 1 && hyprpanel")
    hl.exec_cmd("noctalia")

    -- Using hypridle to start hyprlock
    -- hl.exec_cmd("hypridle")

    -- reload plugins
    -- hl.exec_cmd("hyprpm reload")

    -- Start network manager applet: very important
    hl.exec_cmd("nm-applet --indicator")

    -- Start blueman (bluetooth manager)
    hl.exec_cmd("blueman-applet")

    -- Start wallpaper backend
    -- hl.exec_cmd("awww-daemon") -- disabled cuz using noctalia-shell

    -- Load Notification Daemon
    -- hl.exec_cmd("swaync")

    -- Load cliphist history
    hl.exec_cmd("wl-paste --watch cliphist store")

    -- Setup XDG for screen sharing and start waypaper and waybar
    -- hl.exec_cmd("~/.config/hypr/scripts/xdg.sh")

    -- Start Polkit
    -- hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- Load Wallpaper
    -- hl.exec_cmd("~/.config/hypr/scripts/wallpaper-restore.sh")

    -- Load GTK settings
    -- hl.exec_cmd("~/.config/hypr/scripts/gtk.sh")
end)


---------------
---- INPUT ----
---------------

-- https://wiki.hypr.land/configuring/core/config-options/ (input)
local input_profiles = {
    ["halmak"] = {
        kb_layout          = "halmak_no_qwerty, us, ara",
        kb_variant         = "",
        kb_model           = "",
        kb_options         = "grp:shifts_toggle",
        numlock_by_default = true,
        mouse_refocus      = false,

        follow_mouse = 1,
        touchpad = {
            -- for desktop
            -- natural_scroll = false,

            -- for laptop
            natural_scroll          = true,
            middle_button_emulation = true,
            clickfinger_behavior    = false,
            scroll_factor           = 1.5, -- Touchpad scroll factor
            disable_while_typing    = true,
        },
        sensitivity = 0, -- Pointer speed: -1.0 - 1.0, 0 means no modification.
    },
    ["us"] = {
        -- For United States
        kb_layout  = "us",
        kb_variant = "intl",
        kb_model   = "pc105",
        kb_options = "",

        follow_mouse = 1,
        touchpad = {
            -- for desktop
            -- natural_scroll = false,

            -- for laptop
            natural_scroll          = true,
            middle_button_emulation = true,
            clickfinger_behavior    = false,
            scroll_factor           = 1.5, -- Touchpad scroll factor
        },
        sensitivity = 0, -- Pointer speed: -1.0 - 1.0, 0 means no modification.
    },
}

hl.config({
    input = input_profiles[input_profile],
})

-- Example per-device config
-- See https://wiki.hypr.land/configuring/core/devices/ for more
-- hl.device({
--     name        = "epic-mouse-v1",
--     sensitivity = -0.5,
-- })


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/configuring/core/config-options/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 4,

        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,

        -- Please see https://wiki.hypr.land/configuring/extra/tearing/ before you turn this on
        allow_tearing = false,

        layout = "scrolling",
    },

    decoration = {
        rounding       = 20,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = false,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur = {
            enabled = false,
            size    = 6,
            passes  = 2,

            -- Performance Optimizations
            new_optimizations = true,
            ignore_opacity    = true,
            xray              = true, -- avoids redundant blur passes on layered windows

            -- Downsampling & Performance Limits
            popups  = false,
            special = false,

            -- Aesthetics (gives a smooth frosted glass look on low passes)
            vibrancy   = 0.18,
            noise      = 0.02,
            contrast   = 0.9,
            brightness = 0.8,
        },
    },

    gestures = {
        workspace_swipe_touch = true,
    },

    misc = {
        force_default_wallpaper = -1,   -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
        focus_on_activate       = true, -- Whether Hyprland should focus an app that requests to be focused
    },

    debug = {
        vfr = true,
    },
})

-- Gestures: https://wiki.hypr.land/configuring/core/binds/gestures/
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "vertical",   action = "special", workspace_name = "magic" })

-- Old top-level options with no section; they have no Lua equivalent that I could confirm:
-- remember_window_size = no
-- debug=true


----------------------
---- ANIMATIONS ----
----------------------

-- https://wiki.hypr.land/configuring/core/animations/
-- curves:     { name, x0, y0, x1, y1 }
-- animations: { leaf, speed, bezier, style? }
local animation_profiles = {
    ["optimized"] = {
        curves = {
            -- Using simplified, faster curves
            { "md3_decel", 0.05, 0.7, 0.1, 1 },
            { "md3_accel", 0.3,  0,   0.8, 0.15 },
        },
        anims = {
            -- Reduced durations (from 3 down to 2 or 1.5)
            { "windows",    2, "md3_decel", "popin 80%" },
            { "windowsIn",  2, "md3_decel", "popin 80%" },
            { "windowsOut", 2, "md3_accel", "popin 80%" },

            -- Static elements don't need high-duration animations
            { "border", 5, "default" },
            { "fade",   2, "md3_decel" },

            -- Faster layer and workspace switching
            { "layersIn",      2,   "md3_decel", "slide" },
            { "layersOut",     1.5, "md3_accel" },
            { "fadeLayersIn",  1.5, "md3_decel" },
            { "fadeLayersOut", 2,   "md3_accel" },

            -- Dramatically faster workspace switching (7 -> 3)
            { "workspaces",       3, "md3_decel", "slide" },
            { "specialWorkspace", 2, "md3_decel", "slidevert" },
        },
    },

    ["default"] = {
        curves = {
            { "easeOutQuint",   0.23, 1,    0.32, 1 },
            { "easeInOutCubic", 0.65, 0.05, 0.36, 1 },
            { "linear",         0,    0,    1,    1 },
            { "almostLinear",   0.5,  0.5,  0.75, 1 },
            { "quick",          0.15, 0,    0.1,  1 },
        },
        anims = {
            { "global",        10,   "default" },
            { "border",        5.39, "easeOutQuint" },
            { "windows",       4.79, "easeOutQuint" },
            { "windowsIn",     4.1,  "easeOutQuint", "popin 87%" },
            { "windowsOut",    1.49, "linear",       "popin 87%" },
            { "fadeIn",        1.73, "almostLinear" },
            { "fadeOut",       1.46, "almostLinear" },
            { "fade",          3.03, "quick" },
            { "layers",        3.81, "easeOutQuint" },
            { "layersIn",      4,    "easeOutQuint", "fade" },
            { "layersOut",     1.5,  "linear",       "fade" },
            { "fadeLayersIn",  1.79, "almostLinear" },
            { "fadeLayersOut", 1.39, "almostLinear" },
            { "workspaces",    1.94, "almostLinear", "fade" },
            { "workspacesIn",  1.21, "almostLinear", "fade" },
            { "workspacesOut", 1.94, "almostLinear", "fade" },
            { "zoomFactor",    7,    "quick" },
        },
    },

    -- name "End-4", credit https://github.com/end-4/dots-hyprland
    ["new"] = {
        curves = {
            { "linear",        0,    0,    1,    1 },
            { "md3_standard",  0.2,  0,    0,    1 },
            { "md3_decel",     0.05, 0.7,  0.1,  1 },
            { "md3_accel",     0.3,  0,    0.8,  0.15 },
            { "overshot",      0.05, 0.9,  0.1,  1.1 },
            { "crazyshot",     0.1,  1.5,  0.76, 0.92 },
            { "hyprnostretch", 0.05, 0.9,  0.1,  1.0 },
            { "menu_decel",    0.1,  1,    0,    1 },
            { "menu_accel",    0.38, 0.04, 1,    0.07 },
            { "easeInOutCirc", 0.85, 0,    0.15, 1 },
            { "easeOutCirc",   0,    0.55, 0.45, 1 },
            { "easeOutExpo",   0.16, 1,    0.3,  1 },
            { "softAcDecel",   0.26, 0.26, 0.15, 1 },
            { "md2",           0.4,  0,    0.2,  1 }, -- use with .2s duration
        },
        anims = {
            { "windows",          3,   "md3_decel", "popin 60%" },
            { "windowsIn",        3,   "md3_decel", "popin 60%" },
            { "windowsOut",       3,   "md3_accel", "popin 60%" },
            { "border",           10,  "default" },
            { "fade",             3,   "md3_decel" },
            -- { "layers",        2,   "md3_decel", "slide" },
            { "layersIn",         3,   "menu_decel", "slide" },
            { "layersOut",        1.6, "menu_accel" },
            { "fadeLayersIn",     2,   "menu_decel" },
            { "fadeLayersOut",    4.5, "menu_accel" },
            { "workspaces",       7,   "menu_decel", "slide" },
            -- { "workspaces",    2.5, "softAcDecel", "slide" },
            -- { "workspaces",    7,   "menu_decel", "slidefade 15%" },
            -- { "specialWorkspace", 3, "md3_decel", "slidefadevert 15%" },
            { "specialWorkspace", 3,   "md3_decel", "slidevert" },
        },
    },
}

hl.config({ animations = { enabled = true } })

do
    local profile = animation_profiles[animation_profile]
    for _, c in ipairs(profile.curves) do
        hl.curve(c[1], { type = "bezier", points = { { c[2], c[3] }, { c[4], c[5] } } })
    end
    for _, a in ipairs(profile.anims) do
        hl.animation({ leaf = a[1], enabled = true, speed = a[2], bezier = a[3], style = a[4] })
    end
end


---------------
---- LAYOUT ----
---------------

-- See https://wiki.hypr.land/configuring/layouts/dwindle-layout/ for more
-- hl.config({
--     dwindle = {
--         pseudotile     = true, -- Master switch for pseudotiling. Enabling is bound to mainMod + P
--         preserve_split = true, -- You probably want this
--     },
-- })

-- See https://wiki.hypr.land/configuring/layouts/master-layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/configuring/layouts/scrolling-layout/ for more
hl.config({
    scrolling = {
        column_width             = 0.6,
        fullscreen_on_one_column = true,
        follow_focus             = true,
        focus_fit_method         = 1,
    },
})


---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/configuring/core/binds/

-- [_____ Windows _____]
hl.bind(mainMod .. " + W", hl.dsp.window.close()) -- kill active window
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill")) -- Quit active window and all open instances

-- window navigation using right hand home-row
hl.bind(mainMod .. " + A", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + E", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + O", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + I", hl.dsp.focus({ direction = "right" }))

-- window resize using right hand home-row
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.resize({ x = -100, y = 0,    relative = true })) -- Reduce window width
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.window.resize({ x = 0,    y = 100,  relative = true })) -- Increase window height
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.window.resize({ x = 0,    y = -100, relative = true })) -- Reduce window height
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.window.resize({ x = 100,  y = 0,    relative = true })) -- Increase window width

-- toggle fullscreen and floating
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + Z", hl.dsp.window.float({ action = "toggle" })) -- Toggle active window into floating mode

-- Old: workspaceopt allfloat (toggle all windows on the workspace into floating mode).
-- There's no workspaceopt dispatcher in the Lua API, so this toggles float on every
-- window of the active workspace instead.
hl.bind(mainMod .. " + SHIFT + Z", function()
    local ws = hl.get_active_workspace()
    if ws == nil then return end
    for _, w in ipairs(hl.get_workspace_windows(ws)) do
        hl.dispatch(hl.dsp.window.float({ action = "toggle", window = "address:" .. w.address }))
    end
end)

-- window swap using right hand home-row
hl.bind(mainMod .. " + ALT + A", hl.dsp.window.swap({ direction = "left" }))  -- Swap tiled window left
hl.bind(mainMod .. " + ALT + E", hl.dsp.window.swap({ direction = "down" }))  -- Swap tiled window down
hl.bind(mainMod .. " + ALT + O", hl.dsp.window.swap({ direction = "up" }))    -- Swap tiled window up
hl.bind(mainMod .. " + ALT + I", hl.dsp.window.swap({ direction = "right" })) -- Swap tiled window right

-- toggle window split direction (dwindle layout)
-- hl.bind(mainMod .. " + K", hl.dsp.layout("togglesplit"))

-- swap window split (dwindle layout)
-- hl.bind(mainMod .. " + Y", hl.dsp.layout("swapsplit"))

-- swapcol (scrolling layout)
hl.bind(mainMod .. " + K", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + Y", hl.dsp.layout("swapcol r"))

-- window navigation using ALT TAB (was binde: repeats while held)
hl.bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())                    -- Cycle between windows
    hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))  -- Bring active window to the top
end, { repeating = true })

-- [____ Noctalia shell ____]
local ipc = "noctalia msg "

hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd(ipc .. "panel-toggle wallpaper"))
hl.bind(mainMod .. " + comma",     hl.dsp.exec_cmd(ipc .. "settings-toggle"))
hl.bind(mainMod .. " + period",    hl.dsp.exec_cmd(ipc .. "panel-toggle launcher /emo"))
hl.bind(mainMod .. " + space",     hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. " + V",         hl.dsp.exec_cmd(ipc .. "panel-toggle clipboard")) -- Open clipboard manager
hl.bind("XF86RFKill",              hl.dsp.exec_cmd(ipc .. "lockScreen lock"))        -- Map airplane mode button to lock screen
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd(ipc .. "lockScreen lock"))        -- (same key as resize above; both fire, as before)
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(ipc .. "sessionMenu toggle"))     -- session menu AKA power menu Mod+Shift+P (M in qwerty)

-- [_____ Actions _____]
-- hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("~/.config/waybar/launch.sh"))
hl.bind(mainMod .. " + H",         hl.dsp.exec_cmd([[grim - | tee ~/Pictures/Screenshots/snapshot_$(date +'%Y-%m-%d_%H-%M-%S').png | wl-copy]]))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd([[grim -g "$(slurp -d -p)" - | tee ~/Pictures/Screenshots/snapshot_$(date +'%Y-%m-%d_%H-%M-%S').png | wl-copy]]))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload")) -- Reload Hyprland configuration

-- Old: hyprctl keyword monitor HDMI-A-1,disable
hl.bind(mainMod .. " + CTRL + SHIFT + J", function()
    hl.monitor({ output = "HDMI-A-1", disabled = true })
end)

-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(hyprScripts .. "/screenshot.sh")) -- Take a screenshot
-- TODO: cycle between external monitor profiles using mainMod + J (P in qwerty)

-- [_____ Applications _____]
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty")) -- TODO: try using the terminal variable

-- [_____ Mouse bindings _____]
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true }) -- Move window with the mouse
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- Resize window with the mouse

-- [_____ Workspaces _____]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,            hl.dsp.focus({ workspace = i }))             -- Open workspace i
    hl.bind(mainMod .. " + SHIFT + " .. key,    hl.dsp.window.move({ workspace = i }))       -- Move active window to workspace i
    hl.bind(mainMod .. " + CTRL + " .. key,     hl.dsp.exec_cmd(hyprScripts .. "/moveTo.sh " .. i)) -- Move all windows to workspace i
end

hl.bind(mainMod .. " + Tab",         hl.dsp.focus({ workspace = "m+1" })) -- Open next workspace
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" })) -- Open previous workspace

hl.bind(mainMod .. " + CTRL + down", hl.dsp.focus({ workspace = "empty" })) -- Open the next empty workspace

-- [_____ Special Workspace _____]
-- mapping it to M (X in qwerty)
hl.bind(mainMod .. " + M",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.window.move({ workspace = "special:magic" }))

-- [_____ Fn keys _____]
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -q s +1%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -q s 1%-"))
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ +5%")) -- Increase volume by 5%
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ -5%")) -- Reduce volume by 5%
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))   -- Toggle mute
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"))                        -- Audio play pause
hl.bind("XF86AudioPause",        hl.dsp.exec_cmd("playerctl pause"))                             -- Audio pause
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"))                              -- Audio next
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"))                          -- Audio previous
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle")) -- Toggle microphone
hl.bind("XF86Calculator",        hl.dsp.exec_cmd("~/.config/ml4w/settings/calculator.sh"))       -- Open calculator

hl.bind("code:238", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s +10"))
hl.bind("code:237", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s 10-"))

-- [_____ Custom _____]
-- hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("../scripts/cycle_audio_output.sh"))


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/configuring/core/rules/

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

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

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- Pavucontrol floating
hl.window_rule({
    name  = "floating-pulseaudio-app",
    match = { class = ".*org.pulseaudio.pavucontrol.*" },

    float = true,
})

hl.window_rule({
    name  = "floating-emoji-picker",
    match = { class = ".*org.gnome.Characters.*" },

    float = true,
    pin   = true,
})

hl.window_rule({
    name  = "floating-localsend",
    match = { class = "localsend" },

    float = true,
    pin   = true,
})

hl.window_rule({
    name  = "floating-calculator",
    match = { class = ".*org.gnome.Calculator.*" },

    float = true,
    size  = "700 600",
})

--! IMPORTANT
hl.window_rule({
    name  = "rider-popups-fix",
    match = {
        class = "jetbrains-rider",
        title = "^win(.*)",
        float = true,
    },

    no_focus         = true,
    no_initial_focus = true,
})

hl.window_rule({
    name  = "google-signin-float",
    match = {
        class = "brave-browser",
        title = ".*Sign in – Google accounts.*",
    },

    float = true,
    pin   = true,
})

hl.window_rule({
    name  = "thunar-progress-popup",
    match = {
        class = "thunar",
        title = "File Operation Progress",
    },

    float = true,
})

hl.window_rule({
    name  = "floating-blueman-manager",
    match = { class = "blueman-manager" },

    float = true,
})

hl.layer_rule({
    name  = "noctalia",
    match = { namespace = "noctalia-background-.*$" },

    ignore_alpha = 0.5,
    blur         = true,
    blur_popups  = true,
})

-- Waypaper (disabled)
-- hl.window_rule({ name = "waypaper", match = { class = ".*waypaper.*" }, float = true, size = "900 700", center = true, pin = true })

-- Blueman Manager (older, bigger version, disabled)
-- hl.window_rule({ name = "blueman-big", match = { class = "blueman-manager" }, float = true, size = "800 600", center = true })

-- Emoji Picker Smile (disabled)
-- hl.window_rule({ name = "smile", match = { class = "it.mijorus.smile" }, float = true, pin = true, move = "100%-w-40 90" })

-- SwayNC (disabled)
-- hl.layer_rule({ name = "swaync-control-center", match = { namespace = "swaync-control-center" }, blur = true, ignore_alpha = 0.5 })
-- hl.layer_rule({ name = "swaync-notification-window", match = { namespace = "swaync-notification-window" }, blur = true, ignore_alpha = 0.5 })

-- Ref https://wiki.hypr.land/configuring/core/rules/workspace-rules/
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


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/configuring/core/advanced-configuration/permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--     ecosystem = {
--         enforce_permissions = true,
--     },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


---------------
---- PLUGINS ----
---------------

-- Old plugins.conf only had hyprscrolling options commented out (the scrolling
-- layout is configured above in the LAYOUT section).


-----------------------------
---- NOCTALIA COLORS ----
-----------------------------

-- Was ~/.config/hypr/noctalia.conf (sourced last, so it overrides the border colors above).
-- Noctalia regenerates that file from its color templates; these are the values it had.
local primary        = "rgb(ffffff)"
local surface        = "rgb(131313)"
local secondary      = "rgb(c6c6c6)"
local error          = "rgb(ffb4ab)"
local tertiary       = "rgb(e2e2e2)"
local surface_lowest = "rgb(0e0e0e)"

hl.config({
    general = {
        col = {
            active_border   = primary,
            inactive_border = surface,
        },
    },

    group = {
        col = {
            border_active          = secondary,
            border_inactive        = surface,
            border_locked_active   = error,
            border_locked_inactive = surface,
        },

        groupbar = {
            col = {
                active          = secondary,
                inactive        = surface,
                locked_active   = error,
                locked_inactive = surface,
            },
        },
    },
})

-- For Noctalia Color templates
require("noctalia").apply_theme()
