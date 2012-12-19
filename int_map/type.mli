type primitive_var =
    Bool of bool
  | Float of float
  | Int of int
  | String of string
  | Char of char
  | Unit of unit
type bitv = string
type generic_var = Primitive of primitive_var | Bitv of bitv
val string_of_primitive_var_type : primitive_var -> string
val string_of_primitive_var_value : primitive_var -> string
val string_of_generic_var_type : generic_var -> string
val string_of_generic_var_value : generic_var -> bitv
val string_of_generic_var : generic_var -> string
val hash_key_of_generic_var : generic_var -> int
