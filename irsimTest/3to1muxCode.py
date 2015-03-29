pw = 40
pl = 2
nw = 20
nl = 2

code = "| units: 100 tech: scmos format: MIT\n"

# Select1 buffer and inverter
code += "p sel1in vdd sel1b "+str(pl)+" "+str(pw)+"\n"
code += "n sel1in sel1b gnd "+str(nl)+" "+str(nw)+"\n"
code += "p sel1b vdd sel1 "+str(pl)+" "+str(pw)+"\n"
code += "n sel1b sel1 gnd "+str(nl)+" "+str(nw)+"\n"

# Select2 buffer and inverter
code += "p sel2in vdd sel2b "+str(pl)+" "+str(pw)+"\n"
code += "n sel2in sel2b gnd "+str(nl)+" "+str(nw)+"\n"
code += "p sel2b vdd sel2 "+str(pl)+" "+str(pw)+"\n"
code += "n sel2b sel2 gnd "+str(nl)+" "+str(nw)+"\n"

# Control for in1
code += "p sel1 vdd a "+str(pl)+" "+str(pw)+"\n"
code += "p sel2 vdd a "+str(pl)+" "+str(pw)+"\n"
code += "n sel1 a b "+str(nl)+" "+str(nw)+"\n"
code += "n sel2 b gnd "+str(nl)+" "+str(nw)+"\n"
code += "p a vdd d "+str(pl)+" "+str(pw)+"\n"
code += "n a d gnd "+str(nl)+" "+str(nw)+"\n"

# Control for in2
code += "p sel1b vdd e "+str(pl)+" "+str(pw)+"\n"
code += "p sel2 vdd e "+str(pl)+" "+str(pw)+"\n"
code += "n sel1b e f "+str(nl)+" "+str(nw)+"\n"
code += "n sel2 f gnd "+str(nl)+" "+str(nw)+"\n"
code += "p e vdd g "+str(pl)+" "+str(pw)+"\n"
code += "n e g gnd "+str(nl)+" "+str(nw)+"\n"

# Control for in3
code += "p sel1 vdd h "+str(pl)+" "+str(pw)+"\n"
code += "p sel2b vdd h "+str(pl)+" "+str(pw)+"\n"
code += "n sel1 h i "+str(nl)+" "+str(nw)+"\n"
code += "n sel2b i gnd "+str(nl)+" "+str(nw)+"\n"
code += "p h vdd j "+str(pl)+" "+str(pw)+"\n"
code += "n h j gnd "+str(nl)+" "+str(nw)+"\n"

# Pass logic for mux.
code += "p a in1 out "+str(pl)+" "+str(pw)+"\n"
code += "n d in1 out "+str(nl)+" "+str(nw)+"\n"
code += "p e in2 out "+str(pl)+" "+str(pw)+"\n"
code += "n g in2 out "+str(nl)+" "+str(nw)+"\n"
code += "p h in3 out "+str(pl)+" "+str(pw)+"\n"
code += "n j in3 out "+str(nl)+" "+str(nw)+"\n"


f = open('3to1mux.sim','w')
f.write(code)
f.close()