.PHONY: install uninstall clean test

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
DOCDIR ?= $(PREFIX)/share/doc/nm-hotspot-cli
LICENSEDIR ?= $(PREFIX)/share/licenses/nm-hotspot-cli

install:
	install -Dm755 src/nm-hotspot $(DESTDIR)$(BINDIR)/nm-hotspot
	install -Dm644 LICENSE $(DESTDIR)$(LICENSEDIR)/LICENSE
	install -Dm644 README.md $(DESTDIR)$(DOCDIR)/README.md
	install -Dm644 docs/CONTRIBUTING.md $(DESTDIR)$(DOCDIR)/CONTRIBUTING.md
	install -Dm644 docs/QUICKREF.md $(DESTDIR)$(DOCDIR)/QUICKREF.md

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/nm-hotspot
	rm -rf $(DESTDIR)$(DOCDIR)
	rm -rf $(DESTDIR)$(LICENSEDIR)

clean:
	@echo "Nothing to clean"

test:
	@echo "Running shellcheck on scripts..."
	@command -v shellcheck >/dev/null 2>&1 || { echo "shellcheck not installed"; exit 1; }
	shellcheck src/nm-hotspot scripts/*.sh
	@echo "All checks passed"

install-man:
	install -Dm644 docs/nm-hotspot.1 /usr/share/man/man1/nm-hotspot.1
