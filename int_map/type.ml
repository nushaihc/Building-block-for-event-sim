(* Ocaml primitive types *)
type primitive_var = 
    Bool of bool
  | Float of float
  | Int of int
  | String of string
  | Char of char
  | Unit of unit 

type bitv = string

(* Add your types here *)
type generic_var =
    Primitive of primitive_var
  | Bitv of bitv


let string_of_primitive_var_type = function
    Bool v -> "bool"
  | Float v -> "float"
  | Int v -> "int"
  | String v -> "string"
  | Char v -> "char"
  | Unit v -> "unit"

let string_of_primitive_var_value = function
    Bool v -> string_of_bool v
  | Float v -> string_of_float v
  | Int v -> string_of_int v
  | String v -> v
  | Char v -> String.make 1 v
  | Unit v -> "()"
    

let string_of_generic_var_type = function
    Primitive e -> string_of_primitive_var_type e
  | Bitv e -> "bitv"

let string_of_generic_var_value = function
    Primitive e -> string_of_primitive_var_value e
  | Bitv e -> e


let string_of_generic_var var = 
    let type_string = string_of_generic_var_type var in
    let value_string = string_of_generic_var_value var in
    type_string ^ value_string;;

(* Source : djb2 hash function *)
let hash_key_of_generic_var v (* hash_size *) = 
    let s = string_of_generic_var v in
    let hash = ref 0 in
    for i = 0 to (String.length s - 1) do
        hash := 31 * (!hash) + int_of_char(s.[i]);
(*        hash := !hash mod hash_size *)
    done;
    !hash

(* print_string (string_of_generic_var (Primitive (Char 'a')));; *)
