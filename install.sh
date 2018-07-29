#!/usr/bin/env bash
# -----------------------------------------------------------------------------
#
# DESCRIPTION
#     Install atomic themes.
#
# SYNOPSIS
#     ./install.sh [OPTIONS] [PACKAGES]
#
# OPTIONS
#     -m method   Set the method to use during the process.
#                 Methods available:
#                 1) copy
#                 2) symlink
#
# PACKAGES
#     cmus irssi mutt nvim vim zsh
#     Separate them with a whitespace.
#
# EXAMPLES
#     ./install.sh -m copy cmus irssi mutt nvim vim zsh
#     ./install.sh -m symlink vim cmus
#
# -----------------------------------------------------------------------------

script_dir=$( cd "$( dirname "$0" )" && pwd )

while getopts m: option
do
	case "${option}"
	in
	m) METHOD=${OPTARG};;
	esac
	if [ "$METHOD" == 'copy' ]; then
		USE="cp -i --remove-destination"
	elif [ "$METHOD" == 'symlink' ]; then
		USE="ln -siv"
	fi
done

for ARG in "$@"; do
	if [ "$ARG" == "cmus" ]; then
		dir_cmus="$HOME/.config/cmus/"
		atomic_cmus="$script_dir/cmus/atomic.theme"
		mkdir -p "$dir_cmus"
		$USE "$atomic_cmus" "$dir_cmus"
	fi
	if [ "$ARG" == "irssi" ]; then
		dir_irssi="$HOME/.irssi/"
		atomic_irssi="$script_dir/irssi/atomic.theme"
		mkdir -p "$dir_irssi"
		$USE "$atomic_irssi" "$dir_irssi"
	fi
	if [ "$ARG" == "mutt" ]; then
		dir_mutt="$HOME/.mutt/"
		atomic_mutt="$script_dir/mutt/atomic.muttrc"
		mkdir -p "$dir_mutt"
		$USE "$atomic_mutt" "$dir_mutt"
	fi
	if [ "$ARG" == "zsh" ]; then
		dir_zsh="$HOME/.oh-my-zsh/themes/"
		atomic_zsh1="$script_dir/zsh/atomic.zsh-theme"
		atomic_zsh2="$script_dir/zsh/atomic-powerline.zsh-theme"
		atomic_zsh3="$script_dir/zsh/atomic-lambda.zsh-theme"
		mkdir -p "$dir_zsh"
		$USE "$atomic_zsh1" "$dir_zsh"
		$USE "$atomic_zsh2" "$dir_zsh"
		$USE "$atomic_zsh3" "$dir_zsh"
	fi
done
