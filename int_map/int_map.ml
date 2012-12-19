
module T = Type;;
open Type;;

(* Note: If you want to compile it by ocamlc or ocamlopt *)
open Batteries_uni;;
 (*
open Batteries;; *)
(* module M = Extlib.ExtMap.Map.S;; *)
 module M = Map.IntMap;; 
(* module M = Map.S;; *)

 (*
let empty_m = M.empty in
let m = M.add 1 1 empty_m in
m;;*)

let n = 10000000;;

let rec add_map m x = match x with
    0 -> add_map (M.add 0 0 m) 1
  | k when k <> n -> add_map (M.add k k m) (k + 1)
  | k -> m;;

let a = (Primitive(String "hello"))
let str_a = string_of_generic_var a;;

let _ =
    Printf.printf "string = %s\n" str_a;
    Printf.printf "hash key = %d\n" (hash_key_of_generic_var a 100);;

(* 
let () = 
    Printf.printf "%d\n!" (M.find 100 (add_map M.empty 0));;
*)
