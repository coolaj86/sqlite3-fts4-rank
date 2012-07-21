all: linux
	#Linux

linux:
	gcc -shared -fPIC -Isqlite3 -o fts4-rank.sqlext fts4-rank.c
	#Using GCC on Mac OSX

darwin:
	gcc -bundle -fPIC -Isqlite3 -o fts4-rank.sqlext fts4-rank.c

win32:
	#Microsoft Tools on Windows
	cl /Gd fts4-rank.c /I sqlite3 /DDLL /LD /link /export:sqlite3_extension_init /out:fts4-rank.sqlext
