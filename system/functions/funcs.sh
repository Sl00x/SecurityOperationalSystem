#!bin/bash

function sop_cd() {
    if [ $# -eq 0 ]; then
        cd ./
        echo $PWD
    else
        if [[ "$1" == *"--list"* ]]; then
            cd ${@:2}
            ls -l
            echo TEST
        else
            cd ${@:1}
        fi
        echo $PWD
    fi 
}
function sop_quit() {
    clear
    echo "Bye!"
    exit
}
function sop_logout() {
    _SESSION=0
    main
}
function berror() {
    echo -n -e $_RED$_INVERTED"$1"$_DEFAULT$_NONE
}

function bsuccess() {
    echo -n -e $_GREEN$_INVERTED"$1"$_DEFAULT$_NONE
}

function bnerror() {
    echo -e $_RED$_INVERTED"$1"$_DEFAULT$_NONE
}

function bnsuccess() {
    echo -e $_GREEN$_INVERTED"$1"$_DEFAULT$_NONE
}

function sop_check() {
    if [ -x "$(command -v $1)" ]; then
        echo -e $_GREEN$_INVERTED"$1 is already installed !"$_NONE$_DEFAULT
    else
        echo -e $_RED$_INVERTED"$1 is not installed !"$_NONE$_DEFAULT
        echo -n -e $_BLUE$_INVERTED"Do you want install $1 ? [y/n]"$_NONE$_DEFAULT
        read -n 1 check 
        if [ "$check" == "y" ]; then
            brew install $1
        else
            echo "ok !"
        fi
    fi
}

function sop_adduser() {
    echo -e $_RED "Follow instruction..."$_DEFAULT
    echo -e -n "["$(berror "sop_username")"]:"
    read sop_username
    if [ -d "./profils/$sop_username" ]; then
        bnerror "Sorry this account already exist !"
        echo ""
    else
        echo -e -n "["$(berror "sop_password")"]:"
        read sop_password
        echo -e -n "["$(berror "retype sop_password")"]:"
        read re_sop_password
        if [ "$sop_password" == "$re_sop_password" ]; then
            mkdir ./profils/$sop_username/
            touch ./profils/$sop_username/.pwd
            echo $sop_password >> ./profils/$sop_username/.pwd
            touch ./profils/$sop_username/.forecolor
            echo "\x1B[39m" >> ./profils/$sop_username/.forecolor
            bnsuccess "Your account is now online !"
        fi

    fi
}

function sop_removeuser() {
    if [ ! -z "$1" ]; then
        if [ "$_USERNAME" == "$1" ]; then
            rm -rf ./profils/$1
            bnsuccess "This account is removed !"
            bnerror "You have been disconnected !"
            sop_logout
        else
            bnerror "Sorry you can't remove this account !"
        fi
    fi
}