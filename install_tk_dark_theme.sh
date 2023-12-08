#!/bin/bash

# Go to https://wiki.tcl-lang.org/page/List+of+ttk+Themes and download awdark theme
# or install with apt
# sudo apt install tcl-awthemes
# fix missing awbreezedark.tcl on /usr/share/tcltk/awthemes/
# download tksvg from https://wiki.tcl-lang.org/page/tksvg
# put tksvg on /usr/share/tcltk/

$ mkdir ~/.local/share/tk-themes
$ mkdir ~/.local/share/tk-themes/awthemes
$ mv ~/Downloads/awthemes.tcl ~/.local/share/tk-themes/awthemes/

$ nano ~/.local/share/tk-themes/awthemes/pkgIndex.tcl

package ifneeded ttk::theme::awdark 2.3 [list source [file join $dir awthemes.tcl]]

$ nano ~/.profile

# TK Themes
export TCLLIBPATH=$HOME/.local/share/tk-themes

$ nano ~/.Xresources

*TkTheme: awdark
