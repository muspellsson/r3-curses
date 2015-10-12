REBOL [
	Title:     "REBOL 3 Curses/NCurses extension"
	Purpose:   "This extension provides terminal user interface functions"
	Author:    "Ivan Sukin"
	EMail:     "is@1september.ru"
	File:      %curses.r3
	Copyright: "2015 Ivan Sukin"
	License: {
	        Licensed under the Apache License, Version 2.0.
	        See: http://www.apache.org/licenses/LICENSE-2.0
	}
	Name: curses
	Type: extension
	Version: 0.0.2
	Date: 12/10/2015
	Exports: [initscr endwin]
]

switch fourth system/version [
	3 [
		curses:   make library! %pdcurses.dll
		kernel32: make library! %kernel32.dll

		A_NORMAL:     to-integer #00000000
		A_DIM:        to-integer #00000000
		A_ALTCHARSET: to-integer #00010000
		A_INVIS:      to-integer #00080000
		A_UNDERLINE:  to-integer #00100000
		A_REVERSE:    to-integer #00200000
		A_BLINK:      to-integer #00400000
		A_BOLD:       to-integer #00800000
		A_COLOR:      to-integer #FF000000
		A_ATTRIBUTES: to-integer #FFFF0000
		A_CHARTEXT:   to-integer #0000FFFF
		
		PDC_COLOR_SHIFT: 24
		PDC_ATTR_SHIFT:  20

		COLOR_BLACK:   0
		COLOR_BLUE:    1
		COLOR_GREEN:   2
		COLOR_CYAN:    3
		COLOR_RED:     4
		COLOR_MAGENTA: 5
		COLOR_YELLOW:  6
		COLOR_WHITE:   7

		KEY_CODE_YES:  to-integer #0100
		KEY_BREAK:     to-integer #0101
		KEY_DOWN:      to-integer #0102
		KEY_UP:        to-integer #0103
		KEY_LEFT:      to-integer #0104
		KEY_RIGHT:     to-integer #0105
		
		AllocConsole: make routine! compose [
			[
				return: [int32]
			]
			(kernel32) "AllocConsole"
		]
		
		initscr: func [] [
			AllocConsole
			_initscr
		]
	]
	4 [
		curses: make library! %libncursesw.so

		A_NORMAL:     to-integer #00000000
		A_UNDERLINE:  to-integer #00020000
		A_REVERSE:    to-integer #00040000
		A_BLINK:      to-integer #00080000
		A_DIM:        to-integer #00100000
		A_BOLD:       to-integer #00200000
		A_ALTCHARSET: to-integer #00400000
		A_INVIS:      to-integer #00800000
		A_COLOR:      to-integer #0000FF00
		A_ATTRIBUTES: to-integer #FFFFFF00
		A_CHARTEXT:   to-integer #000000FF

		PDC_COLOR_SHIFT: 8
		PDC_ATTR_SHIFT:  16

		COLOR_BLACK:   0
		COLOR_RED:     1
		COLOR_GREEN:   2
		COLOR_YELLOW:  3
		COLOR_BLUE:    4
		COLOR_MAGENTA: 5
		COLOR_CYAN:    6
		COLOR_WHITE:   7
		
		initscr: func [] [
			_initscr
		]
	]
]

addch: make routine! compose [
	[
		char [int32]
		return: [int32]
	]
	(curses) "addch"
]

attron: make routine! compose [
	[
		attrs [int32]
		return: [int32]
	]
	(curses) "attron"
]

box: make routine! compose [
	[
		win [pointer]
		verch [int32]
		horch [int32]
	]
	(curses) "box"
]

clear: make routine! compose [
	[
		return: [int32]
	]
	(curses) "clear"
]

color-pair: func [
	pair    [integer!]
] [
	(shift pair PDC_COLOR_SHIFT) and A_COLOR
]

curs-set: make routine! compose [
	[
		visibility [int32]
		return: [int32]
	]
	(curses) "curs_set"
]

delwin: make routine! compose [
	[
		win [pointer]
		return: [int32]
	]
	(curses) "delwin"
]

echo: make routine! compose [
	[
		return: [int32]
	]
	(curses) "echo"
]

endwin: make routine! compose [
	[
		return: [int32]
	]
	(curses) "endwin"
]

getch: func [] [
	wgetch stdscr
]

init-pair: make routine! compose [
	[
		pair [int16]
		f    [int16]
		b    [int16]
		return: [int32]
	]
	(curses) "init_pair"
]

__initscr: make routine! compose [
	[
		return: [pointer]
	]
	(curses) "initscr"
]

_initscr: func [] [
	stdscr: __initscr
]

keypad: make routine! compose [
	[
		win [pointer]
		bf  [int32]
		return: [int32]
	]
	(curses) "keypad"
]

mvaddch: make routine! compose [
	[
		y  [int32]
		x  [int32]
		ch [int32]
		return: [int32]
	]
	(curses) "mvaddch"
]

mvaddstr: make routine! compose [
	[
		y   [int32]
		x   [int32]
		str [pointer]
		return: [int32]
	]
	(curses) "mvaddstr"
]

newwin: make routine! compose [
	[
		nlines [int32]
		ncols  [int32]
		begin_y [int32]
		begin_x [int32]
		return: [pointer]
	]
	(curses) "newwin"
]

noecho: make routine! compose [
	[
		return: [int32]
	]
	(curses) "noecho"
]

pair-number: func [
	pair [integer!]
] [
	shift (pair and A_COLOR) (0 - PDC_COLOR_SHIFT)
]

raw: make routine! compose [
	[
		return: [int32]
	]
	(curses) "raw"
]

refresh: make routine! compose [
	[
		return: [int32]
	]
	(curses) "refresh"
]

start-color: make routine! compose [
	[
		return: [int32]
	]
	(curses) "start_color"
]

wgetch: make routine! compose [
	[
		win [pointer]
		return: [int32]
	]
	(curses) "wgetch"
]

wrefresh: make routine! compose [
	[
		win [pointer]
		return: [int32]
	]
	(curses) "wrefresh"
]