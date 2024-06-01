#!/bin/bash
distro=$(lsb_release -is)

if [ "$distro" == "ManjaroLinux" ]; then
  sudo pacman -Syu vim git base-devel mesa qt5-base qt5-multimedia php ttf-inconsolata curl gimp meld p7zip autoconf automake cmake keepassxc mysql postgresql fzf nnn mpv pyenv
  pyenv install 3.8.0
  pyenv global 3.8.0

  cd /var/opt
  git clone https://github.com/klaussilveira/stk.git
  mkdir -p stk/build && cd stk/build && cmake .. && make -j8
  gsettings set org.gnome.desktop.default-applications.terminal exec /var/opt/stk/st
  gsettings set org.gnome.desktop.background primary-color '#000000'
  gsettings set org.gnome.desktop.background secondary-color '#000000'
  gsettings set org.gnome.desktop.background color-shading-type 'solid'
  gsettings set org.gnome.desktop.background picture-uri ''

  git clone https://github.com/adapta-project/adapta-gtk-theme.git
  cd adapta-gtk-theme && ./autogen.sh --prefix=/usr --disable-cinnamon --disable-flashback --disable-xfce --disable-mate --disable-openbox && make && sudo make install


elif [ "$distro" == "Debian" ]; then
  apt install autoconf automake build-essential curl fonts-firacode fonts-inconsolata gimp git gparted pkg-config ninja-build cmake vim libgles2 libgles-dev libx11-dev libx11-xcb-dev libfreetype-dev libxmu-dev libglu1-mesa-dev mesa-common-dev libreadline-dev libasound2-dev libpulse-dev libaudio-dev libjack-dev libsndio-dev libusb-1.0-0-dev libx11-dev libxext-dev libxrandr-dev libxcursor-dev libxfixes-dev libxi-dev libxss-dev libwayland-dev libxkbcommon-dev libdrm-dev libgbm-dev libgl1-mesa-dev libgles2-mesa-dev libegl1-mesa-dev libdbus-1-dev libibus-1.0-dev libudev-dev fcitx-libs-dev

elif [ "$distro" == "Ubuntu" ]; then
    apt purge snapd gnome-software-plugin-snap brltty orca ubuntu-software gnome-software gnome-software-common gnome-shell-extension-ubuntu-dock
    rm -rf ~/snap
    rm -rf /var/cache/snapd/

    add-apt-repository ppa:ondrej/php
    apt update
    apt dist-upgrade

    apt install apache2 apt-transport-https autoconf automake build-essential curl fonts-firacode fonts-inconsolata gimp git gparted gtkpod inkscape keepass2 libapache2-mod-php libgdk-pixbuf2.0-dev libglib2.0-dev libmysqlclient-dev libncursesw5-dev libreadline-dev libssl-dev libx11-dev libx11-dev libx11-xcb-dev libxft-dev libxml2-utils libxrandr-dev meld mysql-client mysql-server p7zip-full php-pear php7.3 php7.3-apcu php7.3-bcmath php7.3-cli php7.3-curl php7.3-dev php7.3-fpm php7.3-gd php7.3-json php7.3-json php7.3-mbstring php7.3-mysql php7.3-pdo php7.3-pgsql php7.3-soap php7.3-xml php7.3-zip pkg-config postgresql redis sassc vim
    apt install --no-install-recommends cups vanilla-gnome-desktop

    apt autoremove
    apt autoclean

    cd /var/opt
    git clone --depth 1 https://github.com/junegunn/fzf.git
    cd fzf && ./fzf/install
    git clone https://github.com/jarun/nnn.git
    cd nnn && make -j8 && sudo make install
    git clone https://github.com/klaussilveira/stk.git
    mkdir -p stk/build && cd stk/build && cmake .. && make -j8
    gsettings set org.gnome.desktop.default-applications.terminal exec /var/opt/stk/st

    apt install autoconf automake inkscape libgdk-pixbuf2.0-dev libglib2.0-dev libxml2-utils

    git clone https://github.com/adapta-project/adapta-gtk-theme.git
    cd adapta-gtk-theme && ./autogen.sh --prefix=/usr --disable-cinnamon --disable-flashback --disable-xfce --disable-mate --disable-openbox && make && sudo make install
else
	echo "Unavailable: $distro";
fi

