
(* state = Initial | Self *)
type state = Initial | Self | Unknown;;

(* type channel = { clk } *)

(* let rec trans_clock state = match state with
    Initial -> Self with *)

let util_print_state state = 
    if true then match state with 
        Initial -> Printf.printf "initial\n"
      | Self -> Printf.printf "self\n"
      | Unknown -> Printf.printf "unknown\n";;


let rec trans_clock state = match state with
    Initial as s -> util_print_state s; trans_clock Self
  | Self as s -> util_print_state s; trans_clock Initial
  | Unknown as s -> util_print_state s; trans_clock Initial

let main () =
   trans_clock Unknown;;

let _ = 
    Printexc.print main ();;
