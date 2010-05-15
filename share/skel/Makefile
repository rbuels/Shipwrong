include shipwrong.conf

build-done:
	bin/shipwright-builder --verbose --skip-test --skip-man-pages --install-base build/
	touch build-done

install: build-done
	mkdir -p $(DESTDIR)/usr/share/
	cp -rl build/ $(DESTDIR)/usr/share/$(PACKAGE_NAME)
	mkdir -p $(DESTDIR)/usr/bin
	for f in `find $(SCRIPTS_DIR) -type f -and -perm /u+x -and -not -name '*~'`; do \
	    bn=`basename $$f`; \
	    ln -sf /usr/share/$(PACKAGE_NAME)/bin/$$bn $(DESTDIR)/usr/bin/$$bn; \
        done

# for each prefixed dist, updates the source to the latest release tag
UPDATE_DISTS=`cd sources; ls -d $(UPDATE_DIST_PREFIX)*`
VERSION_SUMMARY=`perl -MYAML=LoadFile -e '$$u=LoadFile("shipwright/source.yml"); print join ", ", map {($$v) = $$u->{$$_}->{vendor} =~ m!([\d\.]+)$$! or die; "$$_ $$v"} sort grep /^$(UPDATE_DIST_PREFIX)/, keys %{$$u}; print "\n"'`

update:
	bin/shipwrong-update $(UPDATE_DISTS)
	dch --no-auto-nmu -i -b updating to $(VERSION_SUMMARY)
	echo updated to $(VERSION_SUMMARY)

gitupdate: clean update
	git add .
	git add -u .
	(vs=$(VERSION_SUMMARY); git commit -m "$$vs")

deb:
	dpkg-buildpackage -tc -b -rfakeroot -m$$DEBEMAIL

debtest: #< test the debian build with -nc (no clean)
	dpkg-buildpackage -nc -uc -b -rfakeroot -m$$DEBEMAIL

clean:
	 rm -rf dists build build-done __install_base build.log clean.log *-stamp debian/$(PACKAGE_NAME)

.PHONY: install deb clean update

