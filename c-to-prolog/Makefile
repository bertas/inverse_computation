all: $(objects)
	ocamlfind ocamlc -g -o c2p -linkpkg -package unix,cil c2p.ml
	#ocamlfind ocamlopt -g -o c2p -linkpkg -package unix,cil c2p.ml

clean:
	rm -rf *.o *.cmx *.cmi c2p