-- LuCI Model for Cellular Control
local m, s, o

-- Binds this page directly to /etc/config/modemmanager
m = Map("modemmanager", translate("Cellular Manager"), translate("Enable or disable the Universal Modem Connection Watchdog."))

s = m:section(NamedSection, "main", "modemmanager", translate("Watchdog Service Settings"))
s.anonymous = true

-- Adds the visual enable/disable checkbox toggle switch
o = s:option(Flag, "enabled", translate("Enable Service"))
o.default = "1"
o.rmempty = false

o = s:option(Flag, "enable_ipv6", translate("Enable IPv6"))
o.default = "1"
o.rmempty = false

-- Restarts the init daemon service in the background when the user hits "Save & Apply"
function m.on_commit(self)
    os.execute("/etc/init.d/modem-manager restart >/dev/null 2>&1")
end

return m
