$(call inherit-product, vendor/to/config/common_mini.mk)

# Required CM packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/to/config/telephony.mk)
