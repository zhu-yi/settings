#!/bin/bash

SCRIPTDIR=$(cd $(dirname $BASH_SOURCE) && pwd -P)
. $SCRIPTDIR/utils.sh

BASE_PACKAGES="cmake curl git gnupg tar tmux tree cscope exuberant-ctags global
               vim-nox ruby-dev libncurses5-dev openssh-client python3-dev
               python-dev net-tools doxygen bison flex libelf-dev libssl-dev
	       repo openssh-server nasm qemu qemu-user-static graphviz xdot "

YOCTO_PACKAGES="gawk wget diffstat unzip texinfo gcc-multilib build-essential
                chrpath socat cpio python python3 python3-pip python3-pexpect
                python3-git xz-utils debianutils iputils-ping libsdl1.2-dev
		xterm make xsltproc docbook-utils fop dblatex xmlto python-git "

XMIND_PACKAGES="gconf2 gconf-service libappindicator1 "

OPENCV_PACKAGES="build-essential cmake git pkg-config libgtk-3-dev
                 libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
		 libxvidcore-dev libx264-dev libjpeg-dev libpng-dev
		 libtiff-dev gfortran openexr python3-dev python3-numpy
		 libtbb2 libtbb-dev libdc1394-22-dev "

# combine all packages need to check and/or install
#PACKAGES=${BASE_PACKAGES}${YOCTO_PACKAGES}${XMIND_PACKAGES}${OPENCV_PACKAGES}$@

BASE_PKGS="git-all tig tmux tree htop tldr fzf net-tools curl vim-nox cscope
           exuberant-ctags global build-essential cmake python3-dev ruby-dev
           bison flex libncurses5-dev libelf-dev libssl-dev "
OTHER_PKGS="fonts-powerline "
PACKAGES=${BASE_PKGS}${OTHER_PKGS}

declare -a TO_BE_INSTALL

function check_apt_package() {
	infon "Checking '$1' ... "
	dpkg -s "$1" > /dev/null 2>&1 && {
		green "installed."
	} || {
		apt-cache show "$1" > /dev/null 2>&1 && {
			yellow "to be install."
			TO_BE_INSTALL+="$1 "
		} || {
			red "package not exist."
		}
	}
}

function check_apt_packages() {
	info "=========================================================="
	info "                 Start to check packages                  "
	info "=========================================================="

	for package in $PACKAGES; do
		check_apt_package $package
	done
}

function update_packages() {
	info "=========================================================="
	info "                 Start to update packages                "
	info "=========================================================="

	sudo apt-get update && \
	sudo apt-get -y upgrade && \
	sudo apt-get -y dist-upgrade
}

function install_packages() {
	info "=========================================================="
	info "                 Start to install packages                "
	info "=========================================================="

	if [ ${#TO_BE_INSTALL[@]} -eq 0 ]; then
		warn "No new packages need to install."
		return
	fi

	warn "Following packages (and dependencies) will be installed:"
	info "$TO_BE_INSTALL"
	warn "Are you sure? (y/N)"
	read answer
	if [[ ! $answer =~ ^[Yy]$ ]]; then
		warn "Skip install packages"
		return
	fi

	info $TO_BE_INSTALL
	sudo apt-get install -y $TO_BE_INSTALL
}

function usage() {
cat << EOF
Usage: ${0##*/} [option] [packages]
Check managed packages installation status and/or install new packages.

Options: -h|--help      show this help and exit
	 -i|--install   check and install packages if not found
	 -u|--update    update packages aready installed
EOF
}

TEMP=$(getopt -o hiu --long help,install,update -n ${0##*/} -- "$@")
[[ $? -ne 0 ]] && { usage; exit 1; }
eval set -- "$TEMP"

DO_INSTALL=0
DO_UPDATE=0
while true; do
	case "$1" in
	-h|--help)
		usage
		exit 0
		;;
	-i|--install)
		DO_INSTALL=1
		shift
		;;
	-u|--update)
		DO_UPDATE=1
		shift
		;;
	--)
		shift
		break
		;;
	*)
		usage >&2
		exit 1
		;;
	esac
done

PACKAGES+="$@"

check_apt_packages

if [ $DO_UPDATE -eq 1 ]; then
	update_packages
fi

if [ $DO_INSTALL -eq 1 ]; then
	install_packages
fi
