REBOL [
	Title: "REBOL 3 Curses/NCurses extension"
	Purpose: {
	        This extension provides terminal user interface functions
	}
	Author: "Ivan Sukin"
	Copyright: {2015 Ivan Sukin}
	License: {
	        Licensed under the Apache License, Version 2.0.
	        See: http://www.apache.org/licenses/LICENSE-2.0
	}
	Name: curses
	Type: extension
	Version: 0.0.1
	Date: 12/10/2015
	Exports: [init-screen end-window]
]

switch fourth system/version [
	3 [
		curses: make library! %pdcurses.dll
		kernel32: make library! %kernel32.dll
		
		alloc-console: make routine! compose [
			[
				return: [int32]
			]
			(kernel32) "AllocConsole"
		]
		
		init-screen: func [] [
			alloc-console
			initscr
		]
	]
	4 [
		curses: make library! %libncursesw.so
		
		init-screen: func [] [
			initscr
		]
	]
]


initscr: make routine! compose [
	[
		return: [pointer]
	]
	(curses) "initscr"
]

refresh: make routine! compose [
	[
		return: [int32]
	]
	(curses) "refresh"
]

stdscr: make routine! compose [
	[
		return: [pointer]
	]
	(curses) "stdscr"
]

raw: make routine! compose [
	[
		return: [int32]
	]
	(curses) "raw"
]

echo: make routine! compose [
	[
		return: [int32]
	]
	(curses) "echo"
]

noecho: make routine! compose [
	[
		return: [int32]
	]
	(curses) "noecho"
]

keypad: make routine! compose [
	[
		win [pointer]
		bf  [int32]
		return: [int32]
	]
	(curses) "keypad"
]

curs-set: make routine! compose [
	[
		visibility [int32]
		return: [int32]
	]
	(curses) "curs_set"
]

add-char: make routine! compose [
	[
		char [int32]
		return: [int32]
	]
	(curses) "addch"
]

end-window: make routine! compose [
	[
		return: [int32]
	]
	(curses) "endwin"
]

wgetch: make routine! compose [
	[
		win [pointer]
		return: [int32]
	]
	(curses) "wgetch"
]