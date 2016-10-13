THEOS_DEVICE_IP = 192.168.10.106
ARCHS = armv7 arm64
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DockColor
DockColor_FILES = Tweak.xm
DockColor_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += dockcolor
include $(THEOS_MAKE_PATH)/aggregate.mk
