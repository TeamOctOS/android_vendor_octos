# Inherit common CM stuff
$(call inherit-product, vendor/octos/config/common_full.mk)

# Required CM packages
PRODUCT_PACKAGES += \
    LatinIME

# Include CM LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/octos/overlay/dictionaries

$(call inherit-product, vendor/octos/config/telephony.mk)
