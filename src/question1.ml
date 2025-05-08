 (** CW1, QUESTION 1 **)

 (*Filter function*)
 let rec filter p = function
|[]->[]
| h ::t -> if p h then h :: filter p t else filter p t;;

(*Fold Left function*)
let rec foldLeft f acc lst=
match lst with
|[]->acc
|h ::t -> foldLeft f (f acc h)  t;;


(* a (3 marks) *)
 let rec all p xs =
    match xs with
    | [] -> true            (* Base case: An empty list always satisfies the predicate. *)
    | x :: xs ->            (* Check the head of the list and recurse on the tail. *)
    if p x then all p xs    (* If the predicate holds for the head, continue checking the tail. *)
      else                  (* If the predicate is false for the head, return false immediately. *)
        false;;

let isEven n = n mod 2 = 0  (* Function to check if an integer is even. *)

let result1 = all isEven [4; 2; 4; 8]
let result2 = all isEven [2; 2; 5; 1]

(* b (3 marks) *)
let exists p xs =
  (* Define a helper function "check_element" to accumulate results of predicate checks. *)
  let check_element acc x = acc || (p x) in
  (* Use the "foldLeft" function to iterate through the elements of the list "xs". *)
  foldLeft check_element false xs;;

(* Define a function "isEven" that checks if an integer "n" is even. *)
let isEven n = n mod 2 = 0;;

let result1 = exists isEven [1; 3; 4; 5];;
let result2 = exists isEven [5; 1];;

(* c (2 marks) *)
(*The behavior of the all and allF functions varies depending on the input. 
AllF processes every element in the list, including element 5, 
and only after checking the entire list does it return false.
In contrast,'all' stops evaluating as soon as it comes across element 9 (the last element) 
because it doesn't satisfy the predicate.*)
let allF p xs =
   (* Define a helper function "check_element" to accumulate results of predicate checks. *)
  let check_element acc x = acc && p x in
  (* Use the "foldLeft" function to iterate through the elements of the list "xs". *)
  foldLeft check_element true xs;;

let isEven n = n mod 2 = 0;;
(*Example*)
let list = [2; 4; 5; 8; 10];;
let result_all = all isEven list;;
let result_allF = allF isEven list;;
(*They both return the same 'false', but the method they used to get it was different.*)

(* d (2 marks) *)
  let rec member x ys =
    match ys with
    | [] -> false         (* Base case: If the list is empty, "x" is not found, so return "false". *)
    | h :: t -> 
      if h = x then true (*Check if the head "h" is equal to "x"; if so, "x" is a member, so return "true". *)
      else member x t;;  (* If not, recursively search for "x" in the tail "t" of the list. *)

let allSpec p xs =
  (* Define a function "member_predicate" to check if an element is a member of a filtered list. *)
    let member_predicate x = member x (filter p xs) in 
  (* Use the "exists" function to check if there is no element that doesn't satisfy the "member_predicate" for all elements in "xs." *)
    not (exists (fun x -> not (member_predicate x)) xs);;
(*allSpec has the type 'a -> 'a list -> bool, where 'a represents the type of elements in the list*)

let existsSpec p xs =
   (* Use the "exists" function to check if there is at least one element that satisfies the "member" condition for all elements in "xs". *)
    exists (fun x -> member x (filter p xs)) xs;;
(*existsSpec  also has the type 'a -> 'a list -> bool*)