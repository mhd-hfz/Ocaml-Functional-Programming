(** CW1, QUESTION 3 **)

type move = Fill of int | Drain of int | Transfer of int * int;;

(* 1. (4 marks) *)
(* Helper function to get the minimum of two integers *)
let min a b =
  if a < b then a else b;;

(*Map function*)
let rec map f = function
| [] -> []
| h :: t -> f h :: map f t;;
(* For a non-empty list, apply 'p' to the head, and recursively process the tail *)

(* a *)
(* helper function to get the nth element of a list *)
let rec get_idx n lst =
  match n, lst with
  | 0, h :: _ -> h
  | x, _ :: t -> get_idx (x - 1) t;;
(* For other indices, recursively search for the element in the tail of the list *)

(* Helper function to replace the nth element of a list with element 'ele' *)
let rec replace_idx n ele lst =
  match n, lst with
  | 0, _ :: t -> ele :: t
  | n, h :: t -> h :: replace_idx (n - 1) ele t;;
(* For other indices, recursively update the element in the tail of the list *)

(* Helper function to calculate the max amount that can be transferred from jar a to jar b *)
let amtToTransfer a b contents sizes =
  let contentsOfA = get_idx a contents in
  let spaceInB = get_idx b sizes - get_idx b contents in
  min contentsOfA spaceInB;;
(* Calculate the maximum transferable amount by considering the contents of 'a' and available space in 'b' *)

(* Function to perform a move on jars *)
let doMove sizes contents move =
  let rec updateJars m =
    match move with
    | Fill n -> replace_idx n (get_idx n sizes) contents
    (* Fill jar 'n' to its full capacity with liquid *)
    | Drain n -> replace_idx n 0 contents
    (* Drain jar 'n' completely, setting its content to 0 *) 
    | Transfer (m, n) ->
      let amt = amtToTransfer m n contents sizes in
      let newContents = replace_idx m (get_idx m contents - amt) contents in
      replace_idx n (get_idx n contents + amt) newContents in
      (* Transfer liquid from jar 'm' to jar 'n':
         1. Calculate the amount that can be transferred from 'm' to 'n'.
         2. Update the contents of 'm' by subtracting the transferred amount.
         3. Update the contents of 'n' by adding the transferred amount. *)
      updateJars move;;

doMove [5; 2] [5; 0] (Transfer (1, 0));;
doMove [5; 2] [5; 0] (Transfer (0, 1));;
      
(* b *)
let rec check amount contents =
   match contents with
   | [] -> false  (* If the list is empty and no jar contains the required amount, return false *)
   | vol :: rest ->
     if vol = amount then
       true  (* If the current jar contains the required amount, return true *)
     else
       check amount rest ;; (* Recursively check the rest of the jars *)

(* c *)
let run sizes amount moves = 
   (* Recursive helper function to run a sequence of moves *)
  let rec runMoves contents moves = 
    match moves with
    | [] -> contents  (* If there are no more moves to perform, return the final contents of the jars *)
    | h :: t ->
      let updatedContents = doMove sizes contents h in 
        runMoves updatedContents t in
    let initialContents = map (fun _ -> 0) sizes in
    (* Create an initial state where all jars are initially empty *)
    let finalContents = runMoves initialContents moves in
    (* Run the sequence of moves starting from the initial state *)
    check amount finalContents;;
    (* Check if any jar contains the specified 'amount' in the final state *)

(* 2. (6 marks) *)
(* Place the helper functions you define for part 2 of the problem here *)

let rec map f = function
| [] -> []
| h :: t -> f h :: map f t;;

let rec append xs ys =
  match xs with
  | [] -> ys
  | h :: t -> h :: append t ys;;

let rec length lst =
  match lst with
  | [] -> 0
  | _ :: t -> 1 + length t;;

let rec filter p = function
|[]->[]
| h ::t -> if p h then h :: filter p t else filter p t;;

let rec foldLeft f acc lst=
match lst with
|[]->acc
|h ::t -> foldLeft f (f acc h)  t;;

let reverse lst = foldLeft (fun acc x -> x :: acc) [] lst

let rec member x ys =
  match ys with
  | [] -> false
  | h :: t -> if h = x then true else member x t;;

let rec mem state visited =
    match visited with
    | [] -> false
    | x :: xs -> x = state || mem state xs

let solve sizes amount = failwith("Not Implemented")

(* Explain your solution in the comment below; you can also give
   specifications to any helper functions in the comment above, if you
   find them helpful. *)