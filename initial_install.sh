#!/bin/bash

DIR='~'

# Essentials
apt-get install build-essential
apt-get install sudo
apt-get install vim
apt-get install rxvt-unicode
apt-get install linux-headers-$(uname -r)
apt-get install git-core
apt-get install ssh-askpass
apt-get install libjpeg62 libjpeg62-dev
apt-get install checkinstall
apt-get install libpq-dev
apt-get install tcl-dev
apt-get install console-data
apt-get install feh
apt-get install xbindkeys
apt-get install fuse fuse-utils
apt-get install pixmap
apt-get install libmagic-dev

# Display Manager
apt-get install xorg

# Sound
apt-get install alsa-base alsa-utils alsamixergui

# Login Manager
apt-get install slim

# Windows Manager - Xmonad
apt-get install xmoand
apt-get install dzen2
apt-get install conky
apt-get install suckless-tools

# Gtk+ andThemes
apt-get install libgtk2.0-0 libgtk2.0-dev
apt-get install gtk-chtheme gtk-theme-switch
apt-get install gtk2-engines-murrine gtk2-engines-pixbuf
apt-get install gnome-themes-standard
apt-get install gnome-commander

# Configuring keyboard layout
dpkg-reconfigure keyboard-configuration

# Python Packages
apt-get install python-all-dev
apt-get install python-setuptools
easy_install pip
pip install ipython

# Java JDK 7.0
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
apt-get update
apt-get install oracle-java7-installer

# Applications
apt-get install gimp
apt-get install htop
apt-get install gedit
