objects = ctoputil.cmx blacklist.cmx flushmem.cmx loop2rec.cmx splitpath.cmx killmemop.cmx threetuple.cmx killglob.cmx pssa.cmx

all: $(objects)
	ocamlfind ocamlopt -o c2p -linkpkg -package unix,cil $(objects) main.ml

ctoputil.cmx: ctoputil.ml
	ocamlfind ocamlopt -c -package unix,cil ctoputil.ml

blacklist.cmx: blacklist.ml ctoputil.ml
	ocamlfind ocamlopt -c -package unix,cil blacklist.ml

loop2rec.cmx: flushmem.ml loop2rec.ml ctoputil.ml
	ocamlfind ocamlopt -c -package unix,cil loop2rec.ml

splitpath.cmx: splitpath.ml ctoputil.ml
	ocamlfind ocamlopt -c -package unix,cil splitpath.ml

killmemop.cmx: killmemop.ml ctoputil.ml
	ocamlfind ocamlopt -c -package unix,cil killmemop.ml

threetuple.cmx: threetuple.ml ctoputil.ml
	ocamlfind ocamlopt -c -package unix,cil threetuple.ml

flushmem.cmx: flushmem.ml ctoputil.ml
	ocamlfind ocamlopt -c -package unix,cil flushmem.ml

killglob.cmx: killglob.ml ctoputil.ml
	ocamlfind ocamlopt -c -package unix,cil killglob.ml

pssa.cmx: pssa.ml ctoputil.ml
	ocamlfind ocamlopt -c -package unix,cil pssa.ml

objects-db = ctoputil.cmo blacklist.cmo flushmem.cmo loop2rec.cmo splitpath.cmo killmemop.cmo threetuple.cmo killglob.cmo pssa.cmo

ctoputil.cmo: ctoputil.ml
	ocamlfind ocamlc -g -c -package unix,cil ctoputil.ml

blacklist.cmo: blacklist.ml ctoputil.ml
	ocamlfind ocamlc -g -c -package unix,cil blacklist.ml

loop2rec.cmo: loop2rec.ml ctoputil.ml
	ocamlfind ocamlc -g -c -package unix,cil loop2rec.ml

splitpath.cmo: splitpath.ml ctoputil.ml
	ocamlfind ocamlc -g -c -package unix,cil splitpath.ml

killmemop.cmo: killmemop.ml ctoputil.ml
	ocamlfind ocamlc -g -c -package unix,cil killmemop.ml

threetuple.cmo: threetuple.ml ctoputil.ml
	ocamlfind ocamlc -g -c -package unix,cil threetuple.ml

flushmem.cmo: flushmem.ml ctoputil.ml
	ocamlfind ocamlc -g -c -package unix,cil flushmem.ml

killglob.cmo: killglob.ml ctoputil.ml
	ocamlfind ocamlc -g -c -package unix,cil killglob.ml

pssa.cmo: pssa.ml ctoputil.ml
	ocamlfind ocamlc -g -c -package unix,cil pssa.ml

db: $(objects-db)
	ocamlfind ocamlc -g -o c2p-db -linkpkg -package unix,cil $(objects-db) main.ml
