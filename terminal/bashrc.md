# bashrc
How do I change the color for directories with ls in the console?
'''
nano ~/.bashrc
LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS
'''

color
>Blue = 34
>Green = 32
>Light Green = 1;32
>Cyan = 36
>Red = 31
>Purple = 35
>Brown = 33
>Yellow = 1;33
>white = 1;37
>Light Grey = 0;37
>Black = 30
>Dark Grey= 1;30

The first number is the style (1=bold), followed by a semicolon, and then the actual number of the color, possible styles (effects) are:
```
0   = default colour
1   = bold
4   = underlined
5   = flashing text (disabled on some terminals)
7   = reverse field (exchange foreground and background color)
8   = concealed (invisible)
```
The possible backgrounds:
```
40  = black background
41  = red background
42  = green background
43  = orange background
44  = blue background
45  = purple background
46  = cyan background
47  = grey background
100 = dark grey background
101 = light red background
102 = light green background
103 = yellow background
104 = light blue background
105 = light purple background
106 = turquoise background
107 = white background
```
All possible colors:
```
30  = black
31  = red
32  = green
33  = orange
34  = blue
35  = purple
36  = cyan
37  = grey
90  = dark grey
91  = light red
92  = light green
93  = yellow
94  = light blue
95  = light purple
96  = turquoise
97  = white
```
These can even be combined, so that a parameter like:
```
di=1;4;31;42
```
- reference : https://askubuntu.com/questions/466198/how-do-i-change-the-color-for-directories-with-ls-in-the-console
