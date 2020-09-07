#!/bin/bash

SCRIPTDIR=$(cd $(dirname $BASH_SOURCE) && pwd -P)
. $SCRIPTDIR/utils.sh

###############################################################################
# Build git command to sync <repo> in [dir].
#
# $1: used to receive the git command as return value (called with eval)
# $2: url of the remote repository
# $3: local directory to store the repository, optional
###############################################################################
function build_git_cmd() {
	if [ $# -ne 2 ] && [ $# -ne 3 ]; then
		warn "usage: build_git_cmd <cmd> <repo> [dir]"
		exit 1
	fi

	local repo=$2
	if [ $# -eq 3 ]; then
		local dir=$3
	else
		local dir=$(pwd -P)/$(basename $repo .git)
	fi
	local git_dir="$dir/.git"

	if [ -d "$git_dir" ]; then
		# let git reports error if .git is manual created or corrupted
		eval "$1='cd $dir && git pull && \
			  git submodule update --init --recursive && cd ~-'"
	else
		# let git reports error if manual create .git as a file
		eval "$1='git clone --recursive --depth=1 $repo $dir'"
	fi
}

###############################################################################
# Sync <repo> to [dir].
#
# $1: url of the remote repository
# $2: local directory to store the repository, optional
###############################################################################
function sync_git_repo() {
	cmd=""
	build_git_cmd cmd $1 $2

	info "Syncing $1 ... "
	debug $cmd
#	return
	if eval $cmd; then
		info $(green "succeed")
	else
		info $(red "failed")
		exit 1
	fi
}

###############################################################################
# Sync <repos> in turn.
#
# $1: string array in format of ("repo,[dir]" "repo,[dir]" ...)
#     - dir is absolute path, sync to there
#     - dir is relative path, sync to <current_dir>/<dir>
#     - dir is omitted, sync to <current_dir>/<reponame>
###############################################################################
function sync_git_repos() {
	declare -a git_repos=("${!1}")
	for data in "${git_repos[@]}"; do
		repo=$(echo $data | cut -d "," -f 1)
		dir=$(echo $data | cut -d "," -f 2)

		sync_git_repo $repo $dir
	done
}

function install_ycm() {
	info "=========================================================="
	info "                       Install YCM                        "
	info "=========================================================="

	dir=$HOME/.vim/bundle/YouCompleteMe

	if [ -d $dir ]; then
		cd $dir

		if git rev-parse --git-dir > /dev/null 2>&1; then
			python3 install.py --clangd-completer
		else
			error "Not found valid git repo in $dir"
			exit 1
		fi
	else
		error "$dir seems not exist, please sync repo first"
		exit 1
	fi
}

function sync_vim_repos() {
	info "=========================================================="
	info "                     Sync VIM Repos                       "
	info "=========================================================="

	local repos=(\
		"https://github.com/magicmonty/bash-git-prompt.git,$HOME/.bash-git-prompt"
		"https://github.com/ycm-core/YouCompleteMe.git,"
		"https://github.com/jlanzarotta/bufexplorer,"
		"https://github.com/gregsexton/gitv,"
		"https://github.com/majutsushi/tagbar,"
		"https://github.com/edkolev/tmuxline.vim,"
		"https://github.com/vim-airline/vim-airline,"
		"https://github.com/vim-airline/vim-airline-themes,"
		"https://github.com/altercation/vim-colors-solarized,"
		"https://github.com/octol/vim-cpp-enhanced-highlight,"
		"https://github.com/tpope/vim-fugitive,"
		"https://github.com/airblade/vim-gitgutter,"
		"https://github.com/vivien/vim-linux-coding-style,"
		"https://github.com/embear/vim-localvimrc,"
		"https://github.com/tpope/vim-vinegar,"
		"https://github.com/VundleVim/Vundle.vim.git,"
	)

	mkdir -p $HOME/.vim/bundle && \
	cd $HOME/.vim/bundle && \
	sync_git_repos repos[@]
}

function usage() {
cat << EOF
Usage: ${0##*/} [option]
Sync managed git repositories and/or install YouCompleteMe.

Options: -h|--help       show this help and exit
	 -d|--debug      turn on debug information output
	 --no-sync-vim   do not sync vim plugin repositories
	 --install-ycm   install YouCompleteMe
EOF
}

TEMP=$(getopt -o dh --long debug,help,no-sync-vim,install-ycm -n ${0##*/} -- "$@")
[[ $? -ne 0 ]] && { usage; exit 1; }
eval set -- "$TEMP"

NO_SYNC_VIM=0
INSTALL_YCM=0
while true; do
	case "$1" in
		-h|--help)
			usage
			exit 0
			;;
		-d|--debug)
			DEBUG=1
			shift
			;;
		--no-sync-vim)
			NO_SYNC_VIM=1
			shift
			;;
		--install-ycm)
			INSTALL_YCM=1
			shift
			;;
		--)
			shift
			;;
		*)
			if [[ -n $@ ]]; then
				error "Unkown '$@'"
				exit 1
			fi
			break
			;;
	esac
done

if [ $NO_SYNC_VIM -eq 0 ]; then
	sync_vim_repos
else
	debug "Skip sync vim repos"
fi

if [ $INSTALL_YCM -eq 1 ]; then
	install_ycm
else
	debug "Skip install YCM"
fi
