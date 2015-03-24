pw = 40
pl = 2
nw = 20
nl = 2

code = "| units: 100 tech: scmos format: MIT\n"

# Clock buffer/inverter
code += "p clkIn vdd clkb "+str(pl)+" "+str(pw)+"\n"
code += "n clkIn clkb gnd "+str(nl)+" "+str(nw)+"\n"
code += "p clkb vdd clk "+str(pl)+" "+str(pw)+"\n"
code += "n clkb clk gnd "+str(nl)+" "+str(nw)+"\n"

# Qualified clock buffer/inverter
code += "p qualclkIn vdd qualclkb "+str(pl)+" "+str(pw)+"\n"
code += "n qualclkIn qualclkb gnd "+str(nl)+" "+str(nw)+"\n"
code += "p qualclkb vdd qualclk "+str(pl)+" "+str(pw)+"\n"
code += "n qualclkb qualclk gnd "+str(nl)+" "+str(nw)+"\n"

# Latch 1
# Pass trans thru
code += "p qualclkb in a "+str(pl)+" "+str(pw)+"\n"
code += "n qualclk in a "+str(nl)+" "+str(nw)+"\n"
# Pass trans FB
code += "p qualclk d a "+str(pl)+" "+str(pw)+"\n"
code += "n qualclkb d a "+str(nl)+" "+str(nw)+"\n"
# Inv thru
code += "p a vdd b "+str(pl)+" "+str(pw)+"\n"
code += "n a b gnd "+str(nl)+" "+str(nw)+"\n"
# Inv FB
code += "p b vdd d "+str(pl)+" "+str(pw)+"\n"
code += "n b d gnd "+str(nl)+" "+str(nw)+"\n"

# Latch 2
# Pass trans thru
code += "p clkb b e "+str(pl)+" "+str(pw)+"\n"
code += "n clk b e "+str(nl)+" "+str(nw)+"\n"
# Pass trans FB
code += "p clk g e "+str(pl)+" "+str(pw)+"\n"
code += "n clkb g e "+str(nl)+" "+str(nw)+"\n"
# Inv thru
code += "p e vdd out "+str(pl)+" "+str(pw)+"\n"
code += "n e out gnd "+str(nl)+" "+str(nw)+"\n"
# Inv FB
code += "p out vdd g "+str(pl)+" "+str(pw)+"\n"
code += "n out g gnd "+str(nl)+" "+str(nw)+"\n"
# Active low reset
code += "p rstb vdd e "+str(pl)+" "+str(2*pw)+"\n"


f = open(‘register.sim','w')
f.write(code)
f.close()
