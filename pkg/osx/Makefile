INSTALLER=osx-opt-salt-minion-installer

$(INSTALLER): setup-minion.sh salt.zip
	cat $^ > $@
	chmod +x $@

salt.zip: start-salt-minion.sh salt-v2015.8.7-1-g44731f9.pkg
	zip $@ $^

.PHONY:	clean test

clean:
	rm -f $(INSTALLER) salt.zip

test: $(INSTALLER)
	sudo ./cleanup.sh
	sudo ./$(INSTALLER) $(MASTER)
