#!bin/bash
##################################################
#SoP PLUGIN
#plugin: pythonblack
#description:Black Version Of Python for pentest
#version:1.0.0
#author:Sl00x
##################################################

function pythonblack_about() {
  echo 'Description: Black Version Of Python for pentest'
  echo 'Version: 1.0.0'
  echo 'Author: Sl00x'
}

function pythonblack_name() {

	{ # try
    python "./python_script/$1.py" "${@:2}"
	} || { # catch
		echo -e "[$_RED ERROR $_DEFAULT] Can't load file black_python verified if it's install... "
	}
	
}

function pythonblack_install() {

	{ # try
    pip3 install ${@:1} /dev/null
	} || { # catch
		brew install pip
		echo -e "[$_RED ERROR $_DEFAULT] Can't install this library ! "
	}
	
}
