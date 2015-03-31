stepsize 50
w MUXOUT S0 S1 ADDSUB DIVIN REGIN
vector sel S1 S0
vector in ADDSUB DIVIN REGIN
|set to 00, should not respond to any
print OFF
set sel 00
s
set in 000
s
set in 001
s
path MUXOUT
set in 010
s
path MUXOUT
set in 100
s
path MUXOUT
| set to 01, should only respond to ADDSUB
print ADDSUB
set in 000
set sel 01
s
set in 100
s
path MUXOUT
set in 000
s
path MUXOUT
set in 010
s
path MUXOUT
set in 001
s
path MUXOUT
| set to 10, should only respond to DIVIN
print DIVIN
set in 000
set sel 10
s
set in 010
s
path MUXOUT
set in 000
s
path MUXOUT
set in 100
s
path MUXOUT
set in 001
s
path MUXOUT
| set to 11, should only respond to REGIN
print REGIN
set in 000
set sel 11
s
set in 001
s
path MUXOUT
set in 000
s
path MUXOUT
set in 100
s
path MUXOUT
set in 010
s
path MUXOUT
