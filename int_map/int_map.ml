
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

(*
let rec add_map m x = match x with
    0 -> add_map (M.add 0 0 m) 1
  | k when k <> n -> add_map (M.add k k m) (k + 1)
  | k -> m;;
*)

(* @ param  m : map 
 *          startidx : start index
 *          endidx : end index
 *   e.g. add_int_map m 1 3 
 *        -> return map with key pairs of <1, > <2, ><3, >
 *)         
let add_int_map m startidx endidx = 
    let prim_var i = Primitive (Int i) in
    let end_value = endidx + 1 in
    let rec add_int_map_aux m start endidx x = match x with
      | k -> if k = end_value then m 
             else add_int_map_aux (M.add 
                                  (hash_key_of_generic_var (prim_var k))
                                  (prim_var k) 
                                   m) 
                             startidx endidx (k + 1) in
    if startidx = endidx then M.empty
    else if startidx > endidx then failwith "Given start index larger than end index\n"
    else add_int_map_aux M.empty startidx endidx startidx;;

let add_string_map m startidx endidx = 
    let prim_var i = Primitive (String (string_of_int i)) in
    let end_value = endidx + 1 in
    let rec add_int_map_aux m start endidx x = match x with
      | k -> if k = end_value then m 
             else add_int_map_aux (M.add 
                                  (hash_key_of_generic_var (prim_var k))
                                  (prim_var k) 
                                   m) 
                             startidx endidx (k + 1) in
    if startidx = endidx then M.empty
    else if startidx > endidx then failwith "Given start index larger than end index\n"
    else add_int_map_aux M.empty startidx endidx startidx;;

let m1 = add_int_map M.empty 1 10;;
let m2 = add_string_map M.empty 1 10;;

(*
let _ =
    try 
        M.find 10 m1 
    with Not_found ->
        raise Not_found
        *)

let a = (Primitive(String "hello"));;
let str_a = string_of_generic_var a;;

let _ =
    let n = 1000 in
    let target = 10000 in
    let m1 = add_int_map M.empty 1 n in
    let m2 = add_string_map m1 1 n in
    let target_hash_value = hash_key_of_generic_var (Primitive (String
     (string_of_int target))) in  
    try 
        let value = M.find target_hash_value m2 in
        Printf.printf "string = %s\n" (string_of_int target);
        Printf.printf "hash key = %d\n" target_hash_value
 
    with Not_found -> 
        Printf.printf "string = %s\n" (string_of_int target);
        Printf.printf "Not_found\n";; 


(*
let _ =
    Printf.printf "string = %s\n" str_a;
    Printf.printf "hash key = %d\n" (hash_key_of_generic_var a);;
*)


(* 
let () = 
    Printf.printf "%d\n!" (M.find 100 (add_map M.empty 0));;
*)
