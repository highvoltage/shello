#!/bin/bash
# shello - set up a little flag (or 'shell logo'for your command line
# https://github.com/highvoltage/shello
#
# Copyright (c) 2012 David Cordero <david@corderoramirez.es>
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

printf "Choose a background colour:\n"
for colour in $(jot - 1 8); do
    printf ' %s%s%s ' `tput setab $colour`\ \ $colour\ \ `tput op`; 
done
printf "\n> "
read backgroundcolour

printf "\nChoose a foreground colour:\n"
for colour in $(jot - 1 8); do
    printf ' %s%s%s ' `tput setab $backgroundcolour``tput setaf $colour`\ \ $colour\ \ `tput op`; 
done
printf "\n> "
read foregroundcolour

printf "\nType a character or copy and paste one of these unicode ones:\n"
echo " ◉  ♥  ☕ ♫ ☢ ★ ☆ ☣  ☺  ☹  ✉  ☯  ✈  ☮  ✆  ⛃  ☠  ☃  ‽  ⊙"
#TODO:
#echo "based on your hostname, we like this one: ☢"
printf "> "
read character

printf "\nHere is your new shell logo:\n"
printf ' %s%s%s \n' `tput setab $backgroundcolour``tput setaf $foregroundcolour`\ \ $character\ \ `tput op`; 

mkdir -p ~/.config
printf `tput setab $backgroundcolour``tput setaf $foregroundcolour`\ \ $character\ \ `tput op`\  > ~/.config/shello

printf "\nTip: Add this to the end of your .bashrc to enable this shell logo:\n"
printf '     PS1=$(cat ~/.config/shello)$PS1\n\n'
