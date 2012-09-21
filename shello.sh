#!/bin/bash
# shello - set up a little flag (or 'shell logo'for your command line
# https://github.com/highvoltage/shello
#
# Copyright (c) 2012 Jonathan Carter
# This file is released under the MIT/expat license.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

param_auto="false"
# Do simple parsing, getopt(s) is not used following the KISS principle
if [ "$1" = '-a' -o "$1" = '--auto' ]; then
    param_auto="true"
fi

if [ "$param_auto" = "true" ]; then
    backgroundcolour=$[RANDOM%8+40]
    echo -e "Auto choosing background color: \033[1;${backgroundcolour}m $backgroundcolour \033[0;37m"
else
    echo "Choose a background colour:"
    for colour in $(seq 40 47); do
        echo -e "\033[1;"$colour"m  $colour  \033[0;37m  \c"
    done
    echo -e "\n> \c"
    read backgroundcolour
fi

if [ "$param_auto" = "true" ]; then
    foregroundcolour=$[RANDOM%8+30]
    echo -e "Auto choosing foreground color: \033[1;"$backgroundcolour"m\033[1;"$foregroundcolour"m $foregroundcolour \033[0;37m"
else
    echo -e "\nChoose a foreground colour:"
    for colour in $(seq 30 37); do
        echo -e "\033[1;"$colour"m\033[1;"$backgroundcolour"m  $colour  \033[0;37m  \c"
    done
    echo -e "\n> \c"
    read foregroundcolour
fi

logos=(◉ ♥ ☕ ♫ ☢ ★ ☆ ☣ ☺ ☹ ✉ ☯ ✈ ☮ ✆ ⛃ ☠ ☃ ‽ ⊙)
echo -e "\nType a character or copy and paste one of these unicode ones:"
echo "${logos[*]}"

if [ -x "$(which hostname)" -a -x "$(which sed)" ]; then
    sum=0
    for letter in $(hostname | sed -e 's,\.,,g' -e 's,\(.\),\1 ,g')
    do
        sum=$(($sum+$(printf '%d' "'$letter")))
    done
    suggestion="${logos[ $(( $sum % ${#logos[*]} )) ]}"
    echo "based on your hostname, we like this one: $suggestion"
fi

if [ "$param_auto" = "true" ]; then
    character="$suggestion"
else
    echo -e "> \c"
    read character
fi

echo -e "\nHere is your new shell logo:"
echo -e "\033[1;"$backgroundcolour"m\033[1;"$foregroundcolour"m $character \033[0;37m\n"
echo ""

mkdir -p ~/.config
echo '\[\033[1;'$backgroundcolour'm\033[1;'$foregroundcolour'm\]' $character' \[\033[00;00m\] ' > ~/.config/shello

echo "Tip: Add this to the end of your .bashrc to enable this shell logo:"
echo '     PS1=$(cat ~/.config/shello)$PS1'
echo ""
