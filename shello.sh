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

echo "Choose a background colour:"
for colour in $(seq 40 47); do
    echo -e "\e[1;"$colour"m  $colour  \e[0;37m  \c"
done
echo -e "\n> \c"
read backgroundcolour

echo -e "\nChoose a foreground colour:"
for colour in $(seq 30 37); do
    echo -e "\e[1;"$colour"m\e[1;"$backgroundcolour"m  $colour  \e[0;37m  \c"
done
echo -e "\n> \c"
read foregroundcolour

echo -e "\nWould you like to have a character, time, or both?:"
echo -e "\n> [C|t|b]"
read use
{ [ "$use" == "b" ] || [ "$use" == "t" ] ; } && time_code="\t "


if [ "$use" != "t" ]
then
	echo -e "\nType a character or copy and paste one of these unicode ones:"
	echo " ◉  ♥  ☕ ♫ ☢ ★ ☆ ☣  ☺  ☹  ✉  ☯  ✈  ☮  ✆  ⛃  ☠  ☃  ‽  ⊙"
	#TODO:
	#echo "based on your hostname, we like this one: ☢"
	echo -e "> \c"
	read character
fi


echo -e "\nHere is your new shell logo:"
echo -en "\e[1;"$backgroundcolour"m\e[1;"$foregroundcolour"m"
# Only show the example date if neccesary
{ [ "$use" == "b" ] || [ "$use" == "t" ] ; } && echo -n "`date +%H:%M:%S` "
echo -e "$character \e[0;37m"
echo ""

mkdir -p ~/.config
echo '\[\e[1;'$backgroundcolour'm\e[1;'$foregroundcolour'm\]'${time_code:-' '}${character}' \[\e[00;00m\] ' > ~/.config/shello

echo "Tip: Add this to the end of your .bashrc to enable this shell logo:"
echo '     PS1=$(cat ~/.config/shello)$PS1'
echo ""
