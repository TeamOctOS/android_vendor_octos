$(call inherit-product, vendor/octos/config/common_mini.mk)

# Required CM packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/octos/config/telephony.mk)
