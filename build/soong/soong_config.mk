# Insert new variables inside the Octos structure
octos_soong:
	$(hide) mkdir -p $(dir $@)
	$(hide) (\
	echo '{'; \
	echo '"Octos": {'; \
	echo '},'; \
	echo '') > $(SOONG_VARIABLES_TMP)
