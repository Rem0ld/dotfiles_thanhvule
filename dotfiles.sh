#!/bin/bash
# >>> ONLY WORK FOR ME! <<<

printf "Input command:
        1: Backup
        2: Restore
        3: Install NPM Global packages
        4: Install oh-my-zsh
        5: Install zsh plugins
        0: Exit
        \n"
read -rp 'Enter option: ' OPTION

case "$OPTION" in
1)
	echo " -> Backup dotfiles"

	rm -rf ./config/*
	rm -rf ./.prettierrc
	rm -rf ./.zshrc
	rm -rf ./.gitconfig

	cp -r ~/.config/nvim ./config
	cp -r ~/.config/wezterm ./config
	cp -r ~/.config/bat ./config
	cp -r ~/.config/btop ./config
	cp -r ~/.config/paru ./config
	cp ~/.config/starship.toml ./config
	cp ~/.zshrc .
	cp ~/.prettierrc .
	cp ~/.gitconfig .

	git add .
	read -rp 'Commit message: ' MESSAGE
	if [[ -z $MESSAGE ]]; then
		MESSAGE=":arrows_counterclockwise:"
	fi
	git commit -m "$MESSAGE"
	git push
	;;
2)
	echo " -> Config PACMAN"
	sudo sed -i -e 's/^#Color/Color/' /etc/pacman.conf
	sudo sed -i -e 's/^CheckSpace/#CheckSpace/' /etc/pacman.conf
	sudo sed -i -e 's/^#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf
	sudo sed -i -e 's/^#ParallelDownloads = 5/ParallelDownloads = 5\nILoveCandy/' /etc/pacman.conf

	echo " -> Add Chaotic AUR"
	sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
	sudo pacman-key --lsign-key FBA220DFC880C036
	sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
	sudo tee -a /etc/pacman.conf >/dev/null <<EOT
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOT

	echo "  - Refresh Pacman"
	sudo pacman -Syyu
	sudo pacman -S paru-git reflector rsync curl
	sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
	paru -Syyu

	echo "  - Cleanup Gnome Apps"
	paru -Rns epiphany simple-scan totem gnome-photos gnome-software gnome-calendar gnome-font-viewer gnome-contacts gnome-music gnome-weather gnome-maps gnome-clocks cheese

	echo " - Install Rust"
	paru -S rustup
	rustup default stable

	echo " -> Install packages"
	paru -S brave-bin git-delta dconf-editor notion-app-enhanced gopls wl-clipboard extension-manager-git timeshift timeshift-autosnap grub-btrfs tuned dust p7zip checkmake-git taplo-cli rust-analyzer alacritty-git wget curl unzip unrar jq acpi acpi_call acpid dunst trash-cli visual-studio-code-insiders-bin deno qbittorrent pacman-contrib go gofumpt lua-language-server stylua-bin shfmt hadolint-bin shellcheck tree-sitter font-manager noto-fonts noto-fonts-cjk ttf-apple-emoji noto-fonts-extra adw-gtk3 apple_cursor apple-fonts seahorse github-cli lua luajit luarocks docker docker-compose zsh htop fd bat ripgrep zoxide starship exa lazygit lazydocker fnm-bin httpie mongodb-compass resp-app postman-bin dbeaver wezterm-git google-chrome visual-studio-code-bin ibus-bamboo tidy bob-bin

	echo " -> Install Grub theme"
	sudo cp ./grub-themes/arch /usr/share/grub/themes/ -r
	sudo sed -i -e 's/^#*GRUB_GFXMODE=.*/GRUB_GFXMODE=2560x1440/' /etc/default/grub
	sudo sed -i -e 's/^#*GRUB_TIMEOUT=.*/GRUB_TIMEOUT=3/' /etc/default/grub
	sudo sed -i -e 's/^#*GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3"/' /etc/default/grub
	sudo sed -i -e 's/^#*GRUB_THEME=.*/GRUB_THEME="\/usr\/share\/grub\/themes\/arch\/theme.txt"/' /etc/default/grub
	sudo grub-mkconfig -o /boot/grub/grub.cfg

	echo " -> Remap Gnome keys"
	for i in {1..9}; do
		echo "$i"
		gsettings set org.gnome.shell.keybindings "switch-to-application-$i" "['']"
		gsettings set org.gnome.desktop.wm.keybindings "switch-to-workspace-$i" "['<Super>$i']"
		gsettings set org.gnome.desktop.wm.keybindings "move-to-workspace-$i" "['<Super><Shift>$i']"
	done

	echo " -> Create env for ibus"
	env DCONF_PROFILE=ibus dconf write /desktop/ibus/general/preload-engines "['BambooUs', 'Bamboo']" && gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'Bamboo')]"
	sudo tee -a /etc/profile <<END
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT4_IM_MODULE=ibus
export CLUTTER_IM_MODULE=ibus
export GLFW_IM_MODULE=ibus
END

	echo " -> GDM Scale"
	sudo touch /usr/share/glib-2.0/schemas/93_hidpi.gschema.override
	sudo tee -a /usr/share/glib-2.0/schemas/93_hidpi.gschema.override >/dev/null <<EOT
[org.gnome.desktop.interface]
scaling-factor=1
text-scaling-factor=1.25
EOT
	sudo glib-compile-schemas /usr/share/glib-2.0/schemas

	echo " -> Enable Docker Service"
	sudo systemctl enable --now docker.service
	sudo usermod -aG docker $USER
	sudo systemctl restart docker.service

	echo " -> Enable Tuned Service"
	sudo systemctl enable --now tuned.service
	sudo tuned-adm profile latency-performance

	echo " -> Restore dotfiles"
	cp ./config/* ~/.config/ -r
	cp ./.gitconfig ~/
	cp ./.prettierrc ~/
	;;
3)
	echo " -> Install NPM Global packages"
	npm install -g rome pnpm neovim ts-node @nestjs/cli @fsouza/prettierd alex markdownlint-cli yaml-language-server emmet-ls live-server vscode-langservers-extracted typescript dockerfile-language-server-nodejs cssmodules-language-server typescript-language-server yarn npm bash-language-server write-good graphql-language-service-cli
	pnpm install-completion zsh
	;;
4)
	echo " -> Install oh-my-zsh"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	;;
5)
	echo " -> Install zsh plugins"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/hlissner/zsh-autopair ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autopair
	git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions

	cp ./.zshrc ~/
	;;
0)
	echo "Exiting"
	;;
*)
	echo "Invalid command !"
	;;
esac
