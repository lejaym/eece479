pw = 40
pl = 2
nw = 20
nl = 2

code = "| units: 100 tech: scmos format: MIT\n"

# Shift signal buffer
code += "p shiftin vdd shiftb "+str(pl)+" "+str(pw)+"\n"
code += "n shiftin shiftb gnd "+str(nl)+" "+str(nw)+"\n"
code += "p shiftb vdd shift "+str(pl)+" "+str(pw)+"\n"
code += "n shiftb shift gnd "+str(nl)+" "+str(nw)+"\n"

# Pass trans for adjacent register
code += "p shiftb left out "+str(pl)+" "+str(pw)+"\n"
code += "n shift left out "+str(nl)+" "+str(nw)+"\n"

# Pass trans for inline register
code += "p shift in out "+str(pl)+" "+str(pw)+"\n"
code += "n shiftb in out "+str(nl)+" "+str(nw)+"\n"

f = open('shifter.sim','w')
f.write(code)
f.close()