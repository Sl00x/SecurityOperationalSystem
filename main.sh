#!bin/bash

source ./color.sh
source ./system/commands.sh
source ./system/commands_exec.sh
source ./system/commands_args.sh
source ./system/commands_access.sh
source ./system/functions/funcs.sh

_LOADING=0
_SESSION=0

function header_home() {
    echo ""
    echo -e $_NONE"  "$_RED$_INVERTED"                                                                                            "
    sleep 0.1
    echo -e $_NONE"  "$_RED$_INVERTED"                    $_NONE+----------------+$_RED$_INVERTED $_NONE+------------+$_RED$_INVERTED $_NONE+----------------+$_RED$_INVERTED                    "
    sleep 0.1
    echo -e $_NONE"  "$_RED$_INVERTED"                    $_NONE|                |$_RED$_INVERTED $_NONE|            |$_RED$_INVERTED $_NONE|                |$_RED$_INVERTED                    "
    sleep 0.1
    echo -e $_NONE"  "$_RED$_INVERTED"                    $_NONE|     +----------+$_RED$_INVERTED $_NONE+------------+$_RED$_INVERTED $_NONE|     +-----+    |$_RED$_INVERTED                    "
    sleep 0.1
    echo -e $_NONE"  "$_RED$_INVERTED"                    $_NONE|     |$_RED$_INVERTED                           $_NONE|     |$_RED$_INVERTED     $_NONE|    |$_RED$_INVERTED                    "
    sleep 0.1
    echo -e $_NONE"  "$_RED$_INVERTED"                    $_NONE|     |$_RED$_INVERTED                           $_NONE|     |$_RED$_INVERTED     $_NONE|    |$_RED$_INVERTED                    "
    sleep 0.1
    echo -e $_NONE"  "$_RED$_INVERTED"                    $_NONE|     |$_RED$_INVERTED                           $_NONE|     +-----+    |$_RED$_INVERTED                    "
    sleep 0.1
    echo -e $_NONE"  "$_RED$_INVERTED"                    $_NONE|     +----------+----------------+                $_NONE|$_RED$_INVERTED                    "
    sleep 0.1
    echo -e $_NONE"  "$_RED$_INVERTED"                    $_NONE|                |                |     $_NONE+----------+$_RED$_INVERTED                    "
    sleep 0.1
    echo -e $_NONE"  "$_RED$_INVERTED"                    $_NONE+----------+     |     +-----+    |     |$_RED$_INVERTED                               "
    sleep 0.1
    echo -e $_NONE"  "$_RED$_INVERTED"                               $_NONE|     |     |$_RED$_INVERTED     $_NONE|    |     |$_RED$_INVERTED   v1.0.5                      "
    sleep 0.1
    echo -e $_NONE"  "$_RED$_INVERTED"                               $_NONE|     |     |$_RED$_INVERTED     $_NONE|    |     |$_RED$_INVERTED   Alpha                       "
    sleep 0.1
    echo -e $_NONE"  "$_RED$_INVERTED"                               $_NONE|     |     |$_RED$_INVERTED     $_NONE|    |     |$_RED$_INVERTED  PentestBox                   "
    sleep 0.1
    echo -e $_NONE"  "$_RED$_INVERTED"                               $_NONE|     |     |$_RED$_INVERTED     $_NONE|    |     |$_RED$_INVERTED                               "
    sleep 0.1
    echo -e $_NONE"  "$_RED$_INVERTED"                    $_NONE+-----------+    |     +-----+    |     |$_RED$_INVERTED                               "
    sleep 0.1
    echo -e $_NONE"  "$_RED$_INVERTED"                    $_NONE|                |                |     |$_RED$_INVERTED                               "
    sleep 0.1
    echo -e $_NONE"  "$_RED$_INVERTED"                    $_NONE+----------------+----------------+-----+$_RED$_INVERTED                               "
    sleep 0.1
    echo -e $_NONE"  "$_RED$_INVERTED"                                                                                            "$_NONE$_DEFAULT
    sleep 0.1
    echo ""
    sleep 0.1
}

function trigger() {
    echo -n -e $_COLOR_USER"$_USERNAME"$_DEFAULT">"
}

function error() {
    echo -e '['$_RED'('$2')'$_DEFAULT'] ' $1
}
function success() {
    echo -e '['$_GREEN'('$2')'$_DEFAULT'] ' $1
}
function info() {
    echo -e '['$_BLUE'('$2')'$_DEFAULT'] ' $1
}

function cmd_check() {


    
    if [ -z "$1" ]; then
        info "Please enter commands" "WARNING"
    else
        for i in  "${!array_commands[@]}"; do
                if [[ "${array_commands[$i]}" = "$1" ]]; then
                        if [[ "${array_commands_args[$i]}" !=  "false" ]]; then

                            if [ "${array_commands_args[$i]}" =  "true" ]; then
                                if [ $# -gt 1 ]; then
                                    ${array_commands_exec[$i]} ${@:2}
                                else 
                                    info "Missing arguments !" "WARNING"
                                fi
                            fi

                            if [ "${array_commands_args[$i]}" =  "both" ]; then
                                if [ $# -eq 1 ]; then
                                    ${array_commands_exec[$i]}
                                elif [ $# -gt 1 ]; then
                                    ${array_commands_exec[$i]} ${@:2}
                                fi
                            fi
                        else
                            ${array_commands_exec[$i]}
                        fi
                fi
        done
    fi
}

function cmd() {
    trigger
    read commands
    cmd_check $commands
    cmd
}
function logIn() {
    echo -n "username:"
    echo -n -e $_INVERTED
    read username
    echo -n -e $_NONE
    stored="./profils/"$username
    if [ -d $stored ]; then
        pass=$( cat ./profils/$username/.pwd ) 
        echo -n "password:"  
        echo -n -e $_HIDDEN
        read password
        echo -n -e $_NONE
        if [ "$pass" = "$password" ]; then
            _SESSION=1
            _USERNAME=$username

            _COLOR_USER=$( cat ./profils/$username/.forecolor )
            _STATUS_USER=$( cat ./profils/$username/.xdw )
            main
        else
            error "Invalide password :/" "FAILED"
            echo "Try again to log you."
            logIn
        fi
    else
        error "Invalide username :/" "FAILED"
        echo "Try again to log you."
        logIn
    fi
}
function main() {
    clear
    if [ $_SESSION -eq 0 ]; then
    echo "LogIn SoP:"
        logIn
    else
        echo "Initialize SoP:"
        while [ $_LOADING -le 110 ]; do
            sleep 0.1
            echo -n -e $_GREEN"#"
            _LOADING=$((_LOADING + 1))
        done
        echo -n -e $_DEFAULT
        clear
        header_home
        cmd
    fi
    
}

main