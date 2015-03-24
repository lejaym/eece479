pw = 40
pl = 2
nw = 20
nl = 2

code = "| units: 100 tech: scmos format: MIT\n"

# First stage
code += "p cin a b "+str(pl)+" "+str(pw)+"\n"
code += "n cin b d "+str(nl)+" "+str(nw)+"\n"
code += "p in1 vdd a "+str(pl)+" "+str(pw)+"\n"
code += "p in2 vdd a "+str(pl)+" "+str(pw)+"\n"
code += "n in1 d gnd "+str(nl)+" "+str(nw)+"\n"
code += "n in2 d gnd "+str(nl)+" "+str(nw)+"\n"

# Second stage
code += "p in2 vdd e "+str(pl)+" "+str(pw)+"\n"
code += "p in1 e b "+str(pl)+" "+str(pw)+"\n"
code += "n in1 b f "+str(nl)+" "+str(nw)+"\n"
code += "n in2 f gnd "+str(nl)+" "+str(nw)+"\n"

# Third stage
code += "p b g h "+str(pl)+" "+str(pw)+"\n"
code += "n b h i "+str(nl)+" "+str(nw)+"\n"
code += "p in1 vdd g "+str(pl)+" "+str(pw)+"\n"
code += "p in2 vdd g "+str(pl)+" "+str(pw)+"\n"
code += "p cin vdd g "+str(pl)+" "+str(pw)+"\n"
code += "n in1 i gnd "+str(nl)+" "+str(nw)+"\n"
code += "n in2 i gnd "+str(nl)+" "+str(nw)+"\n"
code += "n cin i gnd "+str(nl)+" "+str(nw)+"\n"

# Fourth stage
code += "p in1 vdd j "+str(pl)+" "+str(pw)+"\n"
code += "p in2 j k "+str(pl)+" "+str(pw)+"\n"
code += "p cin k h "+str(pl)+" "+str(pw)+"\n"
code += "n cin h l "+str(nl)+" "+str(nw)+"\n"
code += "n in2 l m "+str(nl)+" "+str(nw)+"\n"
code += "n in1 m gnd "+str(nl)+" "+str(nw)+"\n"

# Outputs
code += "p b vdd cout "+str(pl)+" "+str(pw)+"\n"
code += "n b cout gnd "+str(nl)+" "+str(nw)+"\n"
code += "p h vdd sum "+str(pl)+" "+str(pw)+"\n"
code += "n h sum gnd "+str(nl)+" "+str(nw)+"\n"

# sub signal buffer/inverter
code += "p subin vdd subb "+str(pl)+" "+str(pw)+"\n"
code += "n subin subb gnd "+str(nl)+" "+str(nw)+"\n"
code += "p subb vdd sub "+str(pl)+" "+str(pw)+"\n"
code += "n subb sub gnd "+str(nl)+" "+str(nw)+"\n"

# Add/sub modifier (invert in2 if sub=high)
code += "p truein2 vdd in2b "+str(pl)+" "+str(pw)+"\n"
code += "n truein2 in2b gnd "+str(nl)+" "+str(nw)+"\n"
code += "p subb in2b in2 "+str(pl)+" "+str(pw)+"\n"
code += "n sub in2b in2 "+str(nl)+" "+str(nw)+"\n"
code += "p sub truein2 in2 "+str(pl)+" "+str(pw)+"\n"
code += "n subb truein2 in2 "+str(nl)+" "+str(nw)+"\n"

f = open('adder.sim','w')
f.write(code)
f.close()