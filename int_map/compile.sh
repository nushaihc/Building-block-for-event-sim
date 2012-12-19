ocamlopt -c type.ml
ocamlopt -i type.ml > type.mli
ocamlopt -c type.mli
ocamlfind ocamlopt type.cmx -package batteries -linkpkg int_map.ml 
