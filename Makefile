#!/bin/bash

ifdef ($(LOCALBASE))
	PREFIX=$(LOCALBASE)
else
	PREFIX?=/usr
endif

FILL_M4=m4  -DPREFIX=$(PREFIX) -DLOCALBASE=$(LOCALBASE)

cdm:
	$(FILL_M4) src/$@.in>$@

zzz-cdm-profile.sh:
	$(FILL_M4) src/$@.in>$@

cdmrc:
	$(FILL_M4) src/$@.in>$@

session-scraper:
	$(FILL_M4) src/$@.in>$@

clean:
	rm cdm zzz-cdm-profile.sh cdmrc session-scraper

install: cdm zzz-cdm-profile.sh cdmrc session-scraper
	mkdir -p $(DESTDIR)$(PREFIX)/{bin,share/cdm}
	mkdir -p $(DESTDIR)$(LOCALBASE)/etc/profile.d
	install -m755 cdm $(DESTDIR)$(PREFIX)/bin/
	install -m755 src/xlogout $(DESTDIR)$(PREFIX)/bin/
	install -m755 session-scraper $(DESTDIR)$(PREFIX)/bin/
	install -m644 cdmrc $(DESTDIR)$(LOCALBASE)/etc/cdmrc
	install -m644 src/xinitrc* $(DESTDIR)$(PREFIX)/share/cdm/
	install -m755 zzz-cdm-profile.sh $(DESTDIR)$(LOCALBASE)/etc/profile.d/zzz-cdm-profile.sh
	cp -Rf src/themes $(DESTDIR)$(PREFIX)/share/cdm/
