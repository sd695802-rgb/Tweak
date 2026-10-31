target := iphone:clang:latest:14.0
include $(THEOS)/makefiles/common.mk
TWEAK_NAME = MeluxHarperDialog
MeluxHarperDialog_FILES = Tweak.m
MeluxHarperDialog_CFLAGS = -fobjc-arc
include $(THEOS_MAKE_PATH)/tweak.mk
