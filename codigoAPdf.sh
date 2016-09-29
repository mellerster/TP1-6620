a2ps -1 -g --header="" --left-title="" --left-footer="" --right-footer="" --line-numbers=1 --tabsize=4 -Av $(echo *.{c,S} | sort) -o - | ps2pdf - codigo.pdf
