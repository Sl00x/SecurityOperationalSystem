#!bin/bash
##################################################
#SoP PLUGIN
#plugin: plugin_exec
#description:System to execute many file (C, Python, Bash...)
#version:1.2.0
#author:Sl00x
##################################################

function plugin_exec_about() {
	echo 'Description: System to execute many file (C, Python, Bash...)'
	echo 'Version: 1.2.0'
	echo 'Author: Sl00x'
}

function plugin_exec_script() {
	python=".py"
	clang=".c"
	shell=".sh"
	java=".java"

	if [ -f $1 ]; then
		if [[ "$1" =~ $shell ]]; then
			if [ -x "$(command -v bash)" ]; then
				bash $1 ${@:2}
			else
				echo $_RED$_INVERTED"BASH ARE IS INSTALLING..."
				brew install bash
				clear
				bash $1 
			fi
		fi
	fi
}
