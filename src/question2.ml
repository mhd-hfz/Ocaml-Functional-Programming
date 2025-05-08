(** CW2, QUESTION 2 **)

(* a (3 marks) *)

let rec extractMin xs =
  match xs with
  | [x] -> (x, []) (* Base case: If the list has a single element 'x', return 'x' as the minimum and an empty list as the rest. *)
  | x :: xs ->  
    let (min, rest) = extractMin xs in (* Recursively extract the minimum and the rest from the tail of the list. *)
    if x < min then
      (x, xs)    (* If 'x' is smaller, update result with 'x' as new minimum and 'xs' as the rest. *)
    else
      (min, x :: rest);;  (* If not, keep 'min' as minimum and add 'x' to the rest with 'x :: rest'. *)

let result = extractMin [3;6;1;3;7];; 

(* b (3 marks) *)
let rec extractSort xs =
  match xs with
  | [] -> []    (* Base case: An empty list is already sorted. Return an empty list. *)
  | _ -> let (min, rest) = extractMin xs in
        min :: extractSort rest;;
        (* Extract the minimum element from the list using "extractMin," and prepend it to the sorted result. *)

let sortedList = extractSort [3; 6; 1; 3; 7];;

(* c (2 marks) *)
(* 
  Substitution model:
  extractSort [2;3;1]
  =>[1], extractSort [2;3]
  =>[1;2], extractSort [3]
  =>[1;2;3], extractSort []
  =>[1;2;3]

  Input list: [2; 3; 1]
  extractMin [2; 3; 1] is first called to find the minimum element.

  The input list [2; 3; 1] is non-empty, so we proceed.
  The minimum element is 1, and the rest of the list is [2; 3].
  The minimum element 1 is appended to the 'sortedList' and now we have 1 in the 'sortedList'.

  A recursive call to extractSort [2; 3] is made.

  The input list [2; 3] is non-empty.
  extractMin [2; 3] is again called to find the minimum element.

  The minimum element is 2, and the rest of the list is [3].
  The minimum element 2 is appended to the 'sortedList', so now we have 1; 2 in the 'sortedList'.

  A final recursive call to extractSort [3] is made.

  The input list [3] is also non-empty.
  extractMin [3] is called to find the minimum element.

  The minimum element is 3, and the rest of the list is [] (empty).
  The minimum element 3 is appended to the 'sortedList', finally we get 1; 2; 3 in the sorted list.

  The input list is now empty ([]) and the sorted list is [1; 2; 3].

 *)

(* d (2 marks) *)
(* 
  extractMin :
  Tail recursive - No, extractMin is not tail-recursive because 
  it performs a comparison operation (if x < min) after the recursive call. 
  Generates garbage -  No, extractMin doesn't generate garbage. 
  It doesn't create new data structures or objects during its execution 
  that need to be collected by the garbage collector.

  extractSort :
  Tail recursive - Yes, extractSort is tail-recursive because the recursive call (the last line) 
  is the last operation in the function. There are no additional computations after the recursive call.
  Generates garbage - Yes, extractSort generates some garbage when it prepends 
  the minimum element to the result list, but this garbage is eventually collected.
*)