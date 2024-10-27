num:
		octave src/num_solution.m
analy:
		octave src/analy_solution.m

all: num analy

document:
		pandoc -s doc/document.md -o doc/document.pdf
		sudo fbgs doc/document.pdf

view:
		sudo fbi img/*.jpg

clear:
		rm doc/*.pdf img/*.jpg
