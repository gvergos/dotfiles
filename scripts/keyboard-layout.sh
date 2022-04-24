lang=$(setxkbmap -query | awk '/layout/ {print $2}')

if [[ "$lang" == "us" ]]
then
	setxkbmap gr
else
	setxkbmap us
fi
