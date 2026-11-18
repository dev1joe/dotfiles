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
