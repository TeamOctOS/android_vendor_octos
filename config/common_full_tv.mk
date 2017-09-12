# Inherit common CM stuff
$(call inherit-product, vendor/to/config/common_full.mk)

PRODUCT_PACKAGES += TvSettings

DEVICE_PACKAGE_OVERLAYS += vendor/to/overlay/tv
