-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
require("modules.env")

------------------
---- MONITORS ----
------------------
require("modules.monitors.monitors")

-------------------
---- AUTOSTART ----
-------------------
require("modules.autostart")

---------------
---- INPUT ----
---------------
require("modules.input.input")

-----------------------
---- LOOK AND FEEL ----
-----------------------
require("modules.config")
require("modules.decorations.core")
-- require("modules.decorations.aestheticBlur")

----------------------
---- ANIMATIONS ----
----------------------
require("modules.animations.animations")

---------------
---- LAYOUT ----
---------------
require("modules.layouts")

---------------------
---- KEYBINDINGS ----
---------------------
require("modules.keybindings.halmak")

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
require("modules.apps")

-----------------------------
---- NOCTALIA COLORS ----
-----------------------------
require("noctalia").apply_theme()
