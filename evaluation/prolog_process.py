import re

lines = []
whitelist = ["babel"]

def help(l):
    if '"' in l:
        l = l.replace('"',"'")
    if "&" in l:
        l = l.replace("&","/\\")
    if "|" in l:
        l = l.replace("|","\/")
    if "~" in l:
        l = l.replace("~","\\")
    if "\\N" in l:
        l = l.replace("\\N","\\\\N")
    if "\\T" in l:
        l = l.replace("\\T","\\\\T")
    if "\\R" in l:
        l = l.replace("\\R","\\\\R")
    return l


def help1(l):
    m = re.search("\dL,", l)
    if m:
        d = m.group(0)[:-2]
        l = l.replace(m.group(0), d + ",")


    m = re.search("\dL,", l)
    if m:
        d = m.group(0)[:-2]
        l = l.replace(m.group(0), d + ",")

    m = re.search("\dL ,", l)
    if m:
        d = m.group(0)[0]
        l = l.replace(m.group(0), d + " ,")


    m = re.search("\dUL,", l)
    if m:
        d = m.group(0)[0]
        l = l.replace(m.group(0), d + ",")


    m = re.search("\dUL ,", l)
    if m:
        d = m.group(0)[0]
        l = l.replace(m.group(0), d + " ,")

    m = re.search("/ \d", l)
    if m:
        d = m.group(0).replace('/', '//')
        l = l.replace(m.group(0), d)


    return l

    

for item in whitelist:
    fn = item+".pl"
    with open(fn) as f:
        lines = f.readlines()

    #lines[900] = " :- foreign(babel__implicit_kernel_cache_initc_59(+integer, -integer)).\n"
    #lines[1086] = lines[1086] + "__CIL_RET4 is 1,\n"
    lines = map(help, lines)

    lines = map(help1, lines)

    with open(fn, 'w') as f:
        map(lambda l : f.write(l), lines)
