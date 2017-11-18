$(call inherit-product, vendor/octos/config/common_full.mk)

# Include LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/octos/overlay/dictionaries

$(call inherit-product, vendor/octos/config/telephony.mk)
