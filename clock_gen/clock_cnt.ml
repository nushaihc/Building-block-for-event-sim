
(* state = Initial | Self *)
type state = Initial | Self | XXXUnknown | XXXFinal;;

(* type channel = { clk } *)

(* let rec trans_clock state = match state with
    Initial -> Self with *)


(* @ User control *)
(* @ Note : Control, precedence over debug_all *)
(* @ Options : undebug_all = [true | false] *)
let undebug_all = false 
(* @ User control *)
(* @ Options: let debug_all = [true | false] *)
let debug_all = true

let debug_print_state state = 
    let on = ((true || debug_all) && (not undebug_all)) in
    if on then match state with 
        Initial -> Printf.printf "initial\n"
      | Self -> Printf.printf "self\n"
      | XXXUnknown -> Printf.printf "xxxunknown\n"
      | XXXFinal -> Printf.printf "xxxfinal\n";;


let trans_state state = match state with
    Initial as s -> debug_print_state s;  Self
  | Self as s -> debug_print_state s; Initial
  | XXXUnknown as s -> debug_print_state s; Initial
  | _ -> failwith "Impossible drop through here";;

let rec trans_clock state =
    trans_clock (trans_state state);;


let debug_print_cnt cnt = 
    let on = ((true || debug_all) && (not undebug_all)) in
    if on then Printf.printf "cnt = %d\n" cnt;;

let rec trans_clock_cnt state count = match count with 
    0 -> debug_print_cnt 0; XXXFinal 
  | cnt -> debug_print_cnt cnt; 
      if cnt < 0 then failwith "Negative countdown"
      else trans_clock_cnt (trans_state state) (count - 1)


(* let main () =
    trans_clock XXXUnknown;; *)

let main () =
    trans_clock_cnt XXXUnknown 10;;

let _ = 
    Printexc.print main ();;
  (*
let rec trans_clock_cnt cnt =
    let init = trans_clock XXXUnknown in
    let rec trans_clock_cnt_aux trans_clock_fun cnt =
        if cnt = 0 then ()
        else trans_clock_cnt_aux (trans_clock_fun ()) (cnt - 1) in
    trans_clock_cnt_aux init cnt;;

let main () =
   trans_clock XXXUnknown;;

*)
