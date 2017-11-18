# Inherit common CM stuff
$(call inherit-product, vendor/octos/config/common.mk)

PRODUCT_SIZE := full

# Themes
#PRODUCT_PACKAGES += \
    #HexoLibre

# Recorder
PRODUCT_PACKAGES += \
    Recorder
