#!bin/bash

function header_file() {

    echo "#!bin/bash" >> ./my_plugins/$1.sh
    echo "##################################################" >> ./my_plugins/$1.sh
    echo "#SoP PLUGIN" >> ./my_plugins/$1.sh
    echo "#plugin: $1" >> ./my_plugins/$1.sh
    echo "#description:$2" >> ./my_plugins/$1.sh
    echo "#version:$3" >> ./my_plugins/$1.sh
    echo "#author:$4" >> ./my_plugins/$1.sh
    echo "##################################################" >> ./my_plugins/$1.sh

    echo "" >> ./my_plugins/$1.sh
    echo "function $1_about() {" >> ./my_plugins/$1.sh
    echo "  echo 'Description: $2'" >> ./my_plugins/$1.sh
    echo "  echo 'Version: $3'" >> ./my_plugins/$1.sh
    echo "  echo 'Author: $4'" >> ./my_plugins/$1.sh
    echo "}" >> ./my_plugins/$1.sh

    echo "" >> ./my_plugins/$1.sh
    echo "function $1_name() {" >> ./my_plugins/$1.sh
    echo "  #enter code here" >> ./my_plugins/$1.sh
    echo "}" >> ./my_plugins/$1.sh

    echo "Commands need add into /system/commands.sh"  >> ./my_plugins/more.txt
    echo "Commands need add into /system/commands_exec.sh -> function"  >> ./my_plugins/more.txt
    echo "Commands need add into /system/commands_args.sh if using args (false, both, true)"  >> ./my_plugins/more.txt

}

function addplg() {
    pattern=".sh"
    echo "##########################"
    echo -e $_RED"      Plugin Init"$_DEFAULT
    echo "##########################"
    echo -e -n "["$_RED"plugin_name"$_DEFAULT"]:"
    read plugin_name
    if [  ! -z $plugin_name ]; then
        if [[ "$plugin_name" =~ $pattern ]]; then
            clear
            echo "please don't add extension to file"
            addplg
        else
            if [ ! -f "./my_plugins/$plugin_name.sh" ]; then
                echo -e -n "["$_RED"description"$_DEFAULT"]:"
                read plugin_desc
                echo -e -n "["$_RED"plugin_version"$_DEFAULT"]:"
                read plugin_version
                echo -e -n "["$_RED"plugin_author"$_DEFAULT"]:"
                read plugin_author
                touch "./my_plugins/$plugin_name.sh"
                header_file "$plugin_name" "$plugin_desc" "$plugin_version" "$plugin_author"
                echo -e $_GREEN$_INVERTED"Plugin was created with success !"$_NONE$_DEFAULT
                echo -n -e $_GREEN$_INVERTED"Want to start nano to edit now ?[Y/n]"$_NONE$_DEFAULT
                read check
                if [ "$check" = "Y" ]; then
                    emacs "./my_plugins/$plugin_name.sh"
                fi
            else
                echo -n -e $_RED$_INVERTED"This plugin already exists you want to edit ?[Y/n]"$_NONE$_DEFAULT
                read check
                if [ "$check" = "Y" ]; then
                    emacs "./my_plugins/$plugin_name.sh"
                    emacs "./system/commands.sh"
                    emacs "./system/commands_exec.sh"
                    emacs "./system/commands_args.sh"
                else
                    echo -e $_BLUE$_INVERTED"Press q to quit or other to continu !"$_NONE$_HIDDEN
                    read -n 1 cmds
                    if [ "$cmds" == "q" ]; then
                        echo -e $_NONE$_DEFAULT$_BLUE$_INVERTED"Plugin system was quit"$_NONE$_DEFAULT
                    else
                        echo -e $_DEFAULT$_NONE
                        clear
                        addplg
                    fi
                fi
            fi
        fi
    else
        clear
        echo "Need to enter filename"
        addplg
    fi

}