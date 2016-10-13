THEOS_DEVICE_IP = 192.168.10.106
ARCHS = armv7 arm64
include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = DockColor
DockColor_FILES = dcpRootListController.m
DockColor_INSTALL_PATH = /Library/PreferenceBundles
DockColor_FRAMEWORKS = UIKit
DockColor_PRIVATE_FRAMEWORKS = Preferences
DockColor_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/DockColor.plist$(ECHO_END)
