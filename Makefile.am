## Process this file with automake to produce Makefile.in
## Copyright: Sámediggi/Divvun/UiT
## Licence: GPL v3+

EXTRA_DIST = und.timestamp

KBDGEN=kbdgen
KBDGENPATH=$(GIELLA_CORE)/$(KBDGEN)
RELEASE=-R

# XML_SRC can be a language code or the full xml file name, both given
# by the user
XML_SRC=

# Set the CLDR_SRC variable depending on the value of XML_SRC:
CLDR_SRC=$(if $(findstring .xml,$(XML_SRC)),$(XML_SRC),osx/$(XML_SRC)-t-k0-osx.xml)

configure: banner

.PHONY: banner
banner:
	@echo
	@echo "*** Building keyboards for the $(GTLANG) language. ***"
	@echo

if WANT_MAINTAIN
und.timestamp: ${GTCORE}/keyboards-templates/und/und.timestamp
	@echo
	@echo "	The keyboards templates are newer than this language directory"
	@echo "	To get updated keyboard data and build support, run: "
	@echo
	@echo "${GTCORE}/scripts/merge-templates.sh"
	@echo
	@echo "	The build will die now, but if you do not want to update your"
	@echo "	templates, touch $@ and run make again."
	@exit 1
else
# leave a small note for non-maintainers...
und.timestamp: ${GTCORE}/keyboards-templates/und/und.timestamp
	-cp -v -f $< $@
endif


all-local: desktop

.PHONY: mobile ios android desktop svg osx win x11 draft

mobile: ios android

ios:
	@echo
	@echo "*** iOS build! ***"
	@echo
	PYTHONPATH=$(KBDGENPATH) \
	$(PYTHON) -m $(KBDGEN) -t ios \
		-o ios $(RELEASE) \
		project.yaml

android:
	@echo
	@echo "*** Android build! ***"
	@echo
	PYTHONPATH=$(KBDGENPATH) \
	$(PYTHON) -m $(KBDGEN) -t android \
		-o android $(RELEASE) \
		project.yaml \
		-K targets.android.keyStore=$(GTPRIV)/admin/dev-accounts/dev_keys/sami_keyboard.keystore

desktop: svg osx win x11

osx:
	@echo
	@echo "*** OSX build! ***"
	@echo
	PYTHONPATH=$(KBDGENPATH) \
	$(PYTHON) -m $(KBDGEN) -t osx \
		-o macos $(RELEASE) \
		project.yaml

svg:
	@echo
	@echo "*** SVG build! ***"
	@echo
	PYTHONPATH=$(KBDGENPATH) \
	$(PYTHON) -m $(KBDGEN) -t svg \
		-o doc \
		project.yaml

win:
	@echo
	@echo "*** Windows build! ***"
	@echo
	PYTHONPATH=$(KBDGENPATH) \
	$(PYTHON) -m $(KBDGEN) -t win \
		-o win $(RELEASE) \
		project.yaml

x11:
	@echo
	@echo "*** X11 build! ***"
	@echo
	PYTHONPATH=$(KBDGENPATH) \
	$(PYTHON) -m $(KBDGEN) -t x11 \
		-o linux \
		project.yaml

draft: $(GTLANG)-draft.yaml
$(GTLANG)-draft.yaml:
	@echo
	@echo "*** Building draft keyboard yaml file based on: ***"
	@echo "*** $(GIELLA_TEMPLATES)/keyboards-templates/cldr/keyboards/$(CLDR_SRC)"
	@echo
	@if [[ -f \
	"$(GIELLA_TEMPLATES)/keyboards-templates/cldr/keyboards/$(CLDR_SRC)" ]] ; \
		then \
		PYTHONPATH=$(KBDGENPATH) \
		$(PYTHON) -m kbdgen.cldr cldr2kbdgen \
		$(GIELLA_TEMPLATES)/keyboards-templates/cldr/keyboards/$(CLDR_SRC) \
		$@ ; \
	else \
		echo "*** Template data not found, tried:" ;\
		echo "";\
		echo "$(GIELLA_TEMPLATES)/keyboards-templates/cldr/keyboards/$(CLDR_SRC)";\
		echo "";\
		echo "These are the available templates:";\
		echo " "; \
		ls $(GIELLA_TEMPLATES)/keyboards-templates/cldr/keyboards/*/ ; \
		echo " ";\
		echo "*** Specify the xml sourse as:"; \
		echo "*** XML_SRC=\$$(PLATFORMDIR)/\$$(FILENAME), e.g.:" ; \
		echo " ";\
		echo "make draft XML_SRC=osx/en-CA-t-k0-osx.xml";\
		echo " ";\
	fi

clean-local:
	-rm -rf *.txt

maintainer-clean-local:
	-rm -rf ~/Library/Caches/kbdgen/
	-rm -rf ~/.cache/kbdgen
