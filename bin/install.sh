#!/bin/bash

EMACS_DIRECTORY="$XDG_CONFIG_HOME/emacs"
EMACS_BACKUP_DIRECTORY="$XDG_CONFIG_HOME/emacs-backup"
DOOM_EMACS_PRIVATE_DIRECTORY="$XDG_CONFIG_HOME/doom"
DOOM_EMACS_PRIVATE_BACKUP_DIRECTORY="$XDG_CONFIG_HOME/doom-backup"

if [ -d "$EMACS_DIRECTORY" ]; then
    echo "You had an Emacs configuration. It will backup to $EMACS_BACKUP_DIRECTORY."
    mv $EMACS_DIRECTORY $EMACS_BACKUP_DIRECTORY
fi

if [ -d "$EMACS_DIRECTORY" ]; then
    echo "You had a DOOM configuration. It will backup to $DOOM_EMACS_PRIVATE_BACKUP_DIRECTORY."
    mv $EMACS_DIRECTORY $EMACS_BACKUP_DIRECTORY
fi

echo "Clone remote configuration..."
git clone --depth 1 https://github.com/hlissner/doom-emacs.git $EMACS_DIRECTORY
git clone --depth 1 git@github.com:vhtq18w/doom.d.git $DOOM_EMACS_PRIVATE_DIRECTORY

echo "Refresh DOOM configuration..."
$EMACS_DIRECTORY/bin/doom re

echo "Install dependence..."
if [ -f "/etc/arch-release" ]; then
    sudo pacman -S shellcheck
    sudo pacman -S clang clang-tools-extra
    if [ ! -d "$HOME/build" ]; then
        mkdir $HOME/build
    fi
    yay -S dotnet-sdk-preview
    git clone --depth 1 https://github.com/Microsoft/python-language-server.git $HOME/build/
    cd $HOME/build/python-language-server/src/LanguageServer/Impl
    dotnet build
fi

echo "Finished."
