PRODUCT_VERSION_MAJOR = 8
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE = 0
PRODUCT_VERSION_MILESTONE = 0

# Get the device name and set OCTOS_DEVICE (strips octos_ from TARGET_PRODUCT)
OCTOS_DEVICE = $(shell echo -e $(TARGET_PRODUCT) | cut -d '_' -f2,3)

# Set OCTOS_BUILDTYPE from the env RELEASE_TYPE, for jenkins compat

ifndef OCTOS_BUILDTYPE
    ifdef RELEASE_TYPE
        # Starting with "OCTOS_" is optional
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^OCTOS_||g')
        OCTOS_BUILDTYPE := $(RELEASE_TYPE)
    endif
endif

# Filter out random types, so it'll reset to COMMUNITY
ifeq ($(filter RELEASE NIGHTLY SNAPSHOT EXPERIMENTAL WEEKLY,$(OCTOS_BUILDTYPE)),)
    OCTOS_BUILDTYPE :=
endif

ifdef OCTOS_BUILDTYPE
    ifneq ($(OCTOS_BUILDTYPE), SNAPSHOT)
        ifdef OCTOS_EXTRAVERSION
            # Force build type to EXPERIMENTAL
            OCTOS_BUILDTYPE := EXPERIMENTAL
            # Remove leading dash from OCTOS_EXTRAVERSION
            OCTOS_EXTRAVERSION := $(shell echo $(OCTOS_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to OCTOS_EXTRAVERSION
            OCTOS_EXTRAVERSION := -$(OCTOS_EXTRAVERSION)
        endif
    else
        ifndef OCTOS_EXTRAVERSION
            # Force build type to EXPERIMENTAL, SNAPSHOT mandates a tag
            OCTOS_BUILDTYPE := EXPERIMENTAL
        else
            # Remove leading dash from OCTOS_EXTRAVERSION
            OCTOS_EXTRAVERSION := $(shell echo $(OCTOS_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to OCTOS_EXTRAVERSION
            OCTOS_EXTRAVERSION := -$(OCTOS_EXTRAVERSION)
        endif
    endif
else
    # If OCTOS_BUILDTYPE is not defined, set to COMMUNITY
    OCTOS_BUILDTYPE := COMMUNITY
    OCTOS_EXTRAVERSION :=
endif

ifeq ($(OCTOS_BUILDTYPE), COMMUNITY)
    ifneq ($(TARGET_COMMUNITY_BUILD_ID),)
        OCTOS_EXTRAVERSION := -$(TARGET_COMMUNITY_BUILD_ID)
    endif
endif

ifeq ($(OCTOS_BUILDTYPE), RELEASE)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
        OCTOS_VERSION := OCT-O-$(PRODUCT_VERSION_MILESTONE)-$(shell date -u +%Y%m%d)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(OCTOS_DEVICE)
#        ifeq ($(PRODUCT_VERSION_MAINTENANCE),0)
#            OCTOS_VERSION := OCT-O-$(PRODUCT_VERSION_MILESTONE)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(OCTOS_DEVICE)
#        else
#            OCTOS_VERSION := OCT-O-$(PRODUCT_VERSION_MILESTONE)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(OCTOS_DEVICE)
#        endif
    else
        ifeq ($(TARGET_BUILD_VARIANT),user)
            OCTOS_VERSION := OCT-O-v$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(OCTOS_DEVICE)
        else
            OCTOS_VERSION := OCT-O-v$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(OCTOS_DEVICE)
        endif
    endif
else
    ifeq ($(PRODUCT_VERSION_MINOR),0)
        OCTOS_VERSION := OCT-O-$(OCTOS_BUILDTYPE)$(OCTOS_EXTRAVERSION)-$(shell date -u +%Y%m%d-%H%M)-$(OCTOS_DEVICE)
    else
        OCTOS_VERSION := OCT-O-$(OCTOS_BUILDTYPE)$(OCTOS_EXTRAVERSION)-$(shell date -u +%Y%m%d-%H%M)-$(OCTOS_DEVICE)
    endif
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.octos.version=$(OCTOS_VERSION) \
  ro.octos.releasetype=$(OCTOS_BUILDTYPE) \
  ro.modversion=$(OCTOS_VERSION) \
#  ro.tolegal.url=http://www.cyanogenmod.org/docs/privacy

#-include vendor/cm-priv/keys/keys.mk

OCTOS_DISPLAY_VERSION := $(OCTOS_VERSION)

ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),)
ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),build/target/product/security/testkey)
  ifneq ($(OCTOS_BUILDTYPE), COMMUNITY)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
      ifneq ($(OCTOS_EXTRAVERSION),)
        # Remove leading dash from OCTOS_EXTRAVERSION
        OCTOS_EXTRAVERSION := $(shell echo $(OCTOS_EXTRAVERSION) | sed 's/-//')
        TARGET_VENDOR_RELEASE_BUILD_ID := $(OCTOS_EXTRAVERSION)
      else
        TARGET_VENDOR_RELEASE_BUILD_ID := $(shell date -u +%Y%m%d)
      endif
    else
      TARGET_VENDOR_RELEASE_BUILD_ID := $(TARGET_VENDOR_RELEASE_BUILD_ID)
    endif
    OCTOS_DISPLAY_VERSION=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)
  endif
endif
endif
