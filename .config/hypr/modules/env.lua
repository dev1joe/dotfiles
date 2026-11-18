-- See https://wiki.hypr.land/configuring/core/environment-variables/

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
