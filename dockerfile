FROM lscr.io/linuxserver/webtop:arch-kde

#Shell Config
RUN pacman -Syu zsh git curl fastfetch zoxide unzip jq --noconfirm
RUN usermod -s /bin/zsh abc
RUN cd /tmp && sudo -u abc bash -c 'git clone https://aur.archlinux.org/paru-bin.git && cd paru-bin && yes | makepkg -si && cd .. && rm -rf paru-bin' && chown -R abc /config

#Programms
RUN sudo -u abc paru --noconfirm -S brave-bin nano visual-studio-code-bin

# Remove unwanted Packages
RUN pacman --noconfirm -Rns chromium

#Multilib
RUN echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf && pacman -Syu --noconfirm