#!/bin/bash

echo "Choose a background colour:"
for colour in $(seq 40 47); do
    echo -e "\e[1;"$colour"m  $colour  \e[0;37m  \c"
done
echo -e "\n> \c"
read backgroundcolour

echo -e "\nChoose a foreground colour:"
for colour in $(seq 30 37); do
    echo -e "\e[1;"$colour"m  $colour  \e[0;37m  \c"
done
echo -e "\n> \c"
read foregroundcolour

echo -e "\nType a character or copy and paste one of these unicode ones:"
echo " ◉  ♥  ☕ ♫ ☢ ★ ☆ ☣  ☺  ☹  ➀  ➁  ➂  ➃  ➄  ➅  ➆  ➇  ➈  ➉:"
#TODO:
#echo "based on your hostname, we like this one: ☢"
echo -e "> \c"
read character

echo -e "\nHere is your new shell logo:"
echo -e "\e[1;"$backgroundcolour"m\e[1;"$foregroundcolour"m $character \e[0;37m"
echo ""

mkdir -p ~/.config
echo '\e[1;'$backgroundcolour'm\e[1;'$foregroundcolour'm' $character' \e[0;33m ' > ~/.config/shello

echo "Tip: Add this to the end of your .bashrc to enable this shell logo:"
echo '     PS1=$(cat ~/.config/shello)$PS1'
echo ""
