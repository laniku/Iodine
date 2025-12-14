# Iodine
> Iodine is a chemical element; it has symbol I and atomic number 53. The heaviest of the stable halogens, it exists at standard conditions as a semi-lustrous, non-metallic solid that melts to form a deep violet liquid at 114 °C (237 °F), and boils to a violet gas at 184 °C (363 °F). 

Iodine is a [Universal Blue](https://universal-blue.org/ "Universal Blue") powered distro derrived from [Fedora Silverblue](https://silverblue.fedoraproject.org/ "Fedora Silverblue"), providing a simple [GNOME](https://www.gnome.org/ "GNOME") powered experience on top of a rock solid base. Meant to be a [GalliumOS](https://galliumos.org/ "GalliumOS") alternative for newer Chromebooks, an immutable and easy to update Fedora base is paired with a vanilla kernel to ensure wide hardware support, alongside goodies such as [Keyd](https://github.com/rvaiya/keyd "Keyd"), [Ectool](https://files.tree123.org/utils/x86_64/gnu/ectool "Ectool"), and [Linuxbrew](https://docs.brew.sh/Homebrew-on-Linux "Linuxbrew").

Please note this is a pre-alpha. Quirks are bound to happen, and I'm not responsible for damages caused by you using this on your machine.

This project is heavily based on configurations and other things adapted from other projects, such as:
- [Arctine's TyrianOS](https://arctine.rootsource.cc/ "Arctine's TyrianOS")
- [WeirdTreeThing's Keyboard Mapping Utility](https://github.com/WeirdTreeThing/cros-keyboard-map "WeirdTreeThing's Keyboard Mapping Utility")

#### Known Problems:
- **Nocturne/Atlas/Eve/Sarien/Arcada:** Keyboard mappings are not included by default. This will be fixed later.
- **Chromebooks utilizing CR50:** May sometimes have power/sleep related issues. Try to install MrChromebox's patched Full UEFI firmware.
- **Chromebooks that require legacy ALSA configs or have quirks such as Intel SOF Audio:** Generally work but extra files required for some systems to work are not included by default. This will be fixed later. The majority of SOF-over-I²C systems are functional.
- **Chromebooks using RW_Legacy with SeaBIOS:** Are not supported and unfortunately never will be.
- **Chromebooks utilizing ARM processors:** Are also not supported. There may eventually be a port, but don't count on it just yet.

#### Installation:
Install Fedora Silverblue 43, and rebase using:
`sudo bootc switch ghcr.io/laniku/iodine:latest`
Installing through an ISO is coming soon.
