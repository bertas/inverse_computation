import sys

lines = []
#whitelist = ["babel_foo", "babel_foo1", "bsort.cil"]
#whitelist = ["md5sum.cil", "babel_enc64", "babel_dec64", "babel_init64", "babel_sum", "babel_md5"]
#whitelist = ["md5sum1.cil"]

def help(l):
    items = l.split()
    # if "goto while_break" in l:
    #     l = "break;"
    # if "goto return_label" in l:
    #     l = "return;"
    # if "Pl_Start_Prolog" in l:
    #     l = ""
    # if "Pl_Stop_Prolog" in l:
    #     l = ""
    # if len(items) > 1 and "extern" == items[0] :
    #     l = ""
#    if len(items) > 1 and "#line" == items[0]:
#	l = ""
    if "extern" in l and "Pl_Start_Prolog" in l:
	l = ""
    if "extern" in l and "Pl_Stop_Prolog" in l:
	l = ""
    return l


for item in sys.argv[1:]:
    fn = item+"il.c"
    with open(fn) as f:
        lines = f.readlines()
    lines = map(help, lines)
    #lines[79] = "////" + lines[79]
    lines.insert(0, "#include <stdbool.h>\n static int label = -1;")
    with open(fn, 'w') as f:
	f.writelines(lines)
