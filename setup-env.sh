#!/bin/bash

SCRIPTDIR=$(cd $(dirname $BASH_SOURCE) && pwd -P)

if [[ ! -a ~/.bashrc ]]; then
	ln -s $SCRIPTDIR/bash/bashrc ~/.bashrc
fi

if [[ ! -a ~/.vimrc ]]; then
	ln -s $SCRIPTDIR/vim/vimrc.vim ~/.vimrc
fi

if [[ ! -a ~/.tmux.conf ]]; then
	ln -s $SCRIPTDIR/tmux/tmux.conf ~/.tmux.conf
fi

if [[ ! -a ~/.LESS_TERMCAP ]]; then
	ln -s $SCRIPTDIR/less/LESS_TERMCAP ~/.LESS_TERMCAP
fi

$SCRIPTDIR/lib/package.sh -iu
$SCRIPTDIR/lib/sync-repo.sh -d
