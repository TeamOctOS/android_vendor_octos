# Inherit common CM stuff
$(call inherit-product, vendor/octos/config/common_full.mk)

PRODUCT_PACKAGES += TvSettings

DEVICE_PACKAGE_OVERLAYS += vendor/octos/overlay/tv
