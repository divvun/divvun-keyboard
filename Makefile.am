## Process this file with automake to produce Makefile.in
## Copyright: Sámediggi/Divvun/UiT
## Licence: GPL v3+

EXTRA_DIST = und.timestamp

IOS_AUTOTOOLS=ios-autotools
IOS_AUTOTOOLS_PATH=$(shell echo $$(pwd)/deps/$(IOS_AUTOTOOLS))
IOS_IME=giellakbd-ios
ANDROID_IME=giella-ime
SOFTKBDGEN=kbdgen
DIVVUN_GITHUB=https://github.com/divvun
# RELEASE=-R

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

.PHONY: ios_deps android_deps gen_deps mobile ios android \
        desktop svg osx win x11 draft

ios_deps:
	@echo
	@echo "*** iOS build tool dependency check! ***"
	@echo
	$(MKDIR_P) deps
	cd deps; \
	if ! [ -d $(IOS_AUTOTOOLS) ]; then\
		git clone https://github.com/bbqsrc/$(IOS_AUTOTOOLS).git ; \
	fi ; \
	cd $(IOS_AUTOTOOLS)/ && git pull --all && cd ../ ;

android_deps:
	@echo
	@echo "*** Android build tool dependency check! ***"
	@echo
	$(MKDIR_P) deps
	cd deps; \
	if ! [ -d $(ANDROID_IME) ]; then\
		git clone $(DIVVUN_GITHUB)/$(ANDROID_IME).git ; \
	fi ; \
	cd $(ANDROID_IME)/ && git pull --all

gen_deps:
	@echo
	@echo "*** General build tool dependency check! ***"
	@echo
	$(MKDIR_P) deps
	cd deps; \
	if ! [ -d $(SOFTKBDGEN) ]; then\
		git clone $(DIVVUN_GITHUB)/$(SOFTKBDGEN).git ; \
	fi ; \
	cd $(SOFTKBDGEN)/ && git pull --all

mobile: ios android

ios: gen_deps ios_deps
	@echo
	@echo "*** iOS build! ***"
	@echo
	PYTHONPATH=deps/$(SOFTKBDGEN) \
	PATH=$(IOS_AUTOTOOLS_PATH):$(PATH) \
	$(PYTHON) -m $(SOFTKBDGEN) -t ios \
		-o $(PWD)/ios \
		-r $(DIVVUN_GITHUB)/$(IOS_IME).git $(RELEASE) \
		project.yaml

android: gen_deps android_deps
	@echo
	@echo "*** Android build! ***"
	@echo
	PYTHONPATH=deps/$(SOFTKBDGEN) \
	$(PYTHON) -m $(SOFTKBDGEN) -t android \
		-o android \
		-r deps/$(ANDROID_IME) -b master $(RELEASE) \
		project.yaml \
		-K targets.android.keyStore=$(GTPRIV)/admin/dev-accounts/dev_keys/sami_keyboard.keystore

desktop: svg osx win x11

osx: gen_deps
	@echo
	@echo "*** OSX build! ***"
	@echo
	PYTHONPATH=deps/$(SOFTKBDGEN) \
	$(PYTHON) -m $(SOFTKBDGEN) -t osx \
		-o macos \
		$(RELEASE) \
		project.yaml

svg: gen_deps
	@echo
	@echo "*** SVG build! ***"
	@echo
	PYTHONPATH=deps/$(SOFTKBDGEN) \
	$(PYTHON) -m $(SOFTKBDGEN) -t svg \
		-o doc \
		project.yaml

win: gen_deps
	@echo
	@echo "*** Windows build! ***"
	@echo
	PYTHONPATH=deps/$(SOFTKBDGEN) \
	$(PYTHON) -m $(SOFTKBDGEN) -t win $(RELEASE) \
		-o win \
		project.yaml

x11: gen_deps
	@echo
	@echo "*** X11 build! ***"
	@echo
	PYTHONPATH=deps/$(SOFTKBDGEN) \
	$(PYTHON) -m $(SOFTKBDGEN) -t x11 \
		-o linux \
		project.yaml

draft: $(GTLANG)-draft.yaml
$(GTLANG)-draft.yaml: gen_deps
	@echo
	@echo "*** Building draft keyboard yaml file based on: ***"
	@echo "*** $(GIELLA_TEMPLATES)/keyboards-templates/cldr/keyboards/$(CLDR_SRC)"
	@echo
	@if [[ -f \
	"$(GIELLA_TEMPLATES)/keyboards-templates/cldr/keyboards/$(CLDR_SRC)" ]] ; \
		then \
		PYTHONPATH=deps/$(SOFTKBDGEN) \
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
	-rm -rf *.txt build deps
