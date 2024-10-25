#!/bin/bash

lists_branches() {

echo "Available Branches:"

 git branch

}

create_branche() {

if [ -z "$1" ]; then
	echo "Please provide the Branchname"
	exit 1

	fi 
	git branch "$1"
	echo "Branch '$1' created."
}

delete_branche() {

if [ -z "$1" ]; then
	echo "Please provide the Branch Name."
	exit 1

	fi
	git branch -d "$1"
	echo "Branch '$1' has deleted."
}

merge_branches() {

if [-z "$1" ] || [ -z "$2" ]; then
	echo "please provide the Branches for the merging."
	exit 1

	fi
	git checkout "$2"
	git merge "$1"
	echo "Branch '$1' merged in to branch '$2'."

}

rebase_branches() {
	if [ -z "$1" ] || [ -z "$2" ]; then 
		echo  "please provide the two branch name for the rebasing."
		exit 1

		fi
		git checkout "$1"
		git rebase "$2"
		echo "Branch '$1' rebased on '$2'."
	}


	while getopts "1b:d:m:r:" opt; do
		case "$opt" in 

			1) lists_branches ;;
			b) create_branche "$OPTARG" ;;
			d) delete_branche "$OPTARG" ;;
			m) merge_branches "$OPTARG" "${!OPTIND+1}" ;;
			r) rebase_branches "$OPTARG" "${!OPTIND+1}" ;;
			*) echo "invaliv option" ;;

		esac
	done




