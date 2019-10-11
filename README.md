# Keyboards for the Sámi languages

This repository contains source files and build instructions for developing
mobile keyboards for the Sámi languages. The data and implementations
are licenced under LGPL, and the 
licence is also detailed in the LICENCE file of this directory. The authors
named in the AUTHORS file are available to grant other licencing choices.

Installation and compilation, and a short note on usage, is documented in the
file INSTALL.

Documentation is scattered around on the GiellaLT pages, e.g.:

* [https://giellalt.uit.no/keyboards/Overview.html](https://giellalt.uit.no/keyboards/Overview.html)

This keyboard repository is an umbrella repository to build mobile keyboard
apps for iOS and Android. Presently the layout definitions are stored within
this repository, but later on each language keyboard repository will build a
package and make it available for the keyboard app through a
[Páhkat](https://github.com/divvun/pahkat)
repository.

## Requirements

In order to compile the Sámi mobile keyboards you need:

* the relevant operating system (a recent version)
* [kbdgen](https://github.com/divvun/kbdgen)
* the requirements for kbdgen builds for iOS and Android as described
  [here](https://divvun.github.io/kbdgen/)

## Build

The present build system is targeted at CI integration with Microsoft's
Azure platform. Every push to this repository will trigger a rebuild,
which in the end pushes a signed binary to the respective app stores.

Using the above requirements, it is possible to build locally unsigned
binaries which can be transferred to a tethered phone. See the above links
for details.

## Sources

This repository, ie [https://github.com/giellalt/keyboard-smi](https://github.com/giellalt/keyboard-smi).

## Installation

### Local, unsigned builds

See the developer documentation for each platform.

### Signed builds from the CI platform

Please contact [Divvun](mailto:feedback@divvun.no) to get access to beta
releases. Released apps are available for
[Android](https://play.google.com/store/apps/details?id=no.uit.giella.keyboards.Sami)
and
[iOS](https://itunes.apple.com/us/app/samiske-tastatur/id948386025?ls=1&mt=8).