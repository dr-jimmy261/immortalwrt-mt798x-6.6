include $(TOPDIR)/rules.mk

PKG_NAME:=modem-manager
PKG_VERSION:=1.1.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/modem-manager
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Universal Cellular Modem Connection Manager (with LuCI Page)
  PKGARCH:=all
endef

define Package/modem-manager/description
  An automated connection watchdog loop supporting AT, CM, DHCP, and native PCIe MBIM modes with LuCI control.
endef

define Build/Compile
endef

define Package/modem-manager/install
	# Install the connection automation loop script
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/modem-manager.script $(1)/usr/bin/modem-manager

	# Install system boot hook controls
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/modem-manager.init $(1)/etc/init.d/modem-manager

	# Install the default system configuration structure
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/modem-manager.config $(1)/etc/config/modemmanager

	# Install the Lua UI page under Network -> Cellular Manager menu tree branch
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./files/modem-manager.lua $(1)/usr/lib/lua/luci/model/cbi/modemmanager.lua
	
	# Create entry point link for LuCI top-level controller structure
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	echo 'module("luci.controller.modemmanager", package.seeall) function index() entry({"admin", "network", "modemmanager"}, cbi("modemmanager"), _("Cellular Manager"), 60).dependent = true end' > $(1)/usr/lib/lua/luci/controller/modemmanager.lua
endef

$(eval $(call BuildPackage,modem-manager))
