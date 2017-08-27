# Versioning System
OCTOS_BASE_VERSION =  oreo

ifndef OCTOS_BUILD_TYPE
    OCTOS_BUILD_TYPE := UNOFFICIAL
endif

# Only include OCTOS-Updater for official, weeklies, and rc builds
ifeq ($(filter-out OFFICIAL WEEKLIES RC,$(OCTOS_BUILD_TYPE)),)
    PRODUCT_PACKAGES += \
        OCTOS-Updater
endif

# Sign builds if building an official or weekly build
ifeq ($(filter-out OFFICIAL WEEKLIES,$(OCTOS_BUILD_TYPE)),)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := ../.keys/releasekey
endif

# Set all versions
OCTOS_VERSION := $(TARGET_PRODUCT)-$(OCTOS_BASE_VERSION)-$(shell date -u +%Y%m%d-%H%M)-$(OCTOS_BUILD_TYPE)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.octos.version=$(OCTOS_VERSION) \
    ro.mod.version=$(OCTOS_BUILD_TYPE)-$OCTOS_BASE_VERSION)

