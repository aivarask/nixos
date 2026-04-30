" CTRL-W    delete word to the left of cursor
" CTRL-O D  delete everything to the right of cursor
" CTRL-U    delete everything to the left of cursor
" CTRL-H    backspace/delete
" CTRL-J    insert newline (easier than reaching for the return key)
" CTRL-T    indent current line
" CTRL-D    un-indent current line

# Pattern	Description
.	Matches any character (except a newline).
%a	Matches any letter (alphabetical character).
%c	Matches any control character.
%d	Matches any digit (0-9).
%l	Matches any lowercase letter (a-z).
%u	Matches any uppercase letter (A-Z).
%s	Matches any space character (including spaces, tabs, etc.).
%p	Matches any punctuation character.
%w	Matches any alphanumeric character (letters and digits).
%x	Matches any hexadecimal digit (0-9 and a-f).
*	Matches 0 or more occurrences of the preceding element.
+	Matches 1 or more occurrences of the preceding element.
-	Matches 0 or more occurrences, but as few as possible (non-greedy).
?	Matches 0 or 1 occurrence of the preceding element.
^	Matches the start of a string.
$	Matches the end of a string.
[...]	Matches any single character in the brackets.
%< and %>	Matches the < and > characters.
%-	Matches the - character.
%%	Matches the % character (escape sequence).

# manual
1   Executable programs or shell commands
2   System calls (functions provided by the kernel)
3   Library calls (functions within program libraries)
4   Special files (usually found in /dev)
5   File formats and conventions, e.g. /etc/passwd
6   Games
7   Miscellaneous (including macro packages and conventions), e.g. man(7), groff(7), man-pages(7)
8   System administration commands (usually only for root)
9   Kernel routines [Non standard]
