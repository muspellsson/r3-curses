REBOL []

do %curses.r3

initscr
raw
keypad stdscr 1
noecho
curs-set 0
start-color

x: 0
y: 0

init-pair 1 COLOR_RED COLOR_CYAN
;attron (color-pair 1)
forever [
	clear
	mvaddch y x (to-integer #"@")
	k: getch
	switch k reduce [
		KEY_DOWN  [y: y + 1]
		KEY_UP    [y: y - 1]
		KEY_LEFT  [x: x - 1]
		KEY_RIGHT [x: x + 1]
		
	]
]
endwin