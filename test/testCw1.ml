open QCheck

(* utility functions *)

let rec member y xs =
  match xs with
  | [] -> false
  | x :: xs -> y = x || member y xs

let sum xs =
  let rec aux n xs =
    match xs with
    | [] -> n
    | x :: xs -> aux (n + x) xs
  in aux 0 xs

let maxs xs =
  let rec aux b xs =
    match xs with
    | [] -> b
    | x :: xs -> aux (max b x) xs
  in aux 0 xs

let len xs =
  let rec aux n xs =
    match xs with
    | [] -> n
    | _ :: xs -> aux (n + 1) xs
  in aux 0 xs

let rec map f xs =
  match xs with
  | [] -> []
  | x :: xs -> f x :: map f xs

let rec insAll y xs =
  (y :: xs) ::
    match xs with
    | [] -> []
    | x :: xs -> map (fun ys -> x :: ys) (insAll y xs)

let rec islb m xs =
  match xs with
  | [] -> true
  | x :: xs -> m <= x && islb m xs

let rec isSorted xs =
  match xs with
  | [] -> true
  | x :: xs -> islb x xs && isSorted xs

(* Question 1 *)

module Q1 = Cw1.Question1

let _ = print_string ("================================================================================\n"
                    ^ "=== Testing Question 1 =========================================================\n")

let example1AT =
  Test.make ~count:1 unit (fun _ -> Q1.all (fun n -> n mod 2 = 0) [4; 2; 4; 8] = true)

let example1AF =
  Test.make ~count:1 unit (fun _ -> Q1.all (fun n -> n mod 2 = 0) [2; 2; 5; 1] = false)

let example1BT =
  Test.make ~count:1 unit (fun _ -> Q1.exists (fun n -> n mod 2 = 0) [1; 3; 4; 5] = true)

let example1BF =
  Test.make ~count:1 unit (fun _ -> Q1.exists (fun n -> n mod 2 = 0) [5; 1] = false)

let testAllEmpty1 = Test.make ~count:1 unit (fun _ -> Q1.all (fun _ -> false) [] = true)
let testAllEmpty2 = Test.make ~count:1 unit (fun _ -> Q1.all (fun _ -> true)  [] = true)
let testExistsEmpty1 = Test.make ~count:1 unit (fun _ -> Q1.exists (fun _ -> false) [] = false)
let testExistsEmpty2 = Test.make ~count:1 unit (fun _ -> Q1.exists (fun _ -> true)  [] = false)

let n1 = QCheck_runner.run_tests ~out:stdout
           [ example1AT
           ; example1AF
           ; example1BT
           ; example1BF
           ; testAllEmpty1
           ; testAllEmpty2
           ; testExistsEmpty1
           ; testExistsEmpty2
           ]


(* Question 2 *)

module Q2 = Cw1.Question2

let extrMinLB xs =
  let (m, rst) = Q2.extractMin xs
  in islb m rst

let extrMinCorr xs =
  let (m, rst) = Q2.extractMin xs
  in member xs (insAll m rst)

let extrSortStd xs =
  isSorted (Q2.extractSort xs)

let extrSortLen xs =
  len xs = len (Q2.extractSort xs)

let extrSortSum xs =
  sum xs = sum (Q2.extractSort xs)

let testEMLB = Test.make ~name:"Extracted element is a lower bound of the remaining ones"
                 (list int) (function | [] -> assume_fail ()
                                      | _::_ as xs -> extrMinLB xs)

let testEMC  = Test.make ~name:"Extraction of minimum preserves elements and order of original list"
                 (list int) (function | [] -> assume_fail ()
                                      | _::_ as xs -> extrMinCorr xs)

let testESStd = Test.make ~name:"Extraction sort produces a sorted list"
                  (list int) extrSortStd

let testESLen = Test.make ~name:"Extraction sort does not modify the length of the list"
                  (list int) extrSortLen

let testESSum = Test.make ~name:"Extraction sort does not modify the sum of elts"
                  (list int) extrSortSum

let _ = print_string ("================================================================================\n"
                    ^ "=== Testing Question 2 =========================================================\n")

let n2 = QCheck_runner.run_tests ~out:stdout
           [testEMLB; testEMC; testESStd; testESLen; testESSum]

(* Question 3*)

let _ = print_string ("================================================================================\n"
                    ^ "=== Testing Question 3 =========================================================\n")

module Q3 = Cw1.Question3



let testSelfCheck (xs, n) =
  match Q3.solve xs n with
  | Some ms -> Q3.run xs n ms
  | None -> true

let prob : ('int list * int) arbitrary =
  let open Gen in
  let triple n =
    map3 (fun a b c -> [a; b; c]) (int_range 1 n) (int_range 1 n) (int_range 1 n) in
  let gen =
    triple 14 >>= (fun xs -> map (fun v -> (xs, v)) (int_range 1 (maxs xs)))
  in 
  make ~print:Print.(pair (list int) int) gen

let testSelf = Test.make ~name:"Run matches solve" ~count:10
                  prob testSelfCheck

let testDoMoveT1 = 
    Test.make 
    ~name:"Transfer test 1"
    ~count:1 unit (fun _ -> Q3.doMove [5;2] [5;0] (Transfer (0,1)) = [3;2])

let testDoMoveT2 = 
    Test.make 
    ~name:"Transfer test 2"
    ~count:1 unit (fun _ -> Q3.doMove [5;2;6] [5;0;0] (Transfer (0,2)) = [0;0;5])

let testDoMoveT3 = 
    Test.make 
    ~name:"Transfer test 3"
    ~count:1 unit (fun _ -> Q3.doMove [1;2;4] [0;0;4] (Transfer (2,0)) = [1;0;3])

let testDoMoveF1 = 
    Test.make 
    ~name:"Fill test 1"
    ~count:1 unit (fun _ -> Q3.doMove [5;2] [5;0] (Fill 0) = [5;0])

let testDoMoveF2 = 
    Test.make 
    ~name:"Fill test 2"
    ~count:1 unit (fun _ -> Q3.doMove [5;2] [5;0] (Fill 1) = [5;2])

let testDoMoveF3 = 
    Test.make 
    ~name:"Fill test 3"
    ~count:1 unit (fun _ -> Q3.doMove [1;3;5;2] [0;0;5;0] (Fill 3) = [0;0;5;2])

let testDoMoveD1 = 
    Test.make 
    ~name:"Drain test 1"
    ~count:1 unit (fun _ -> Q3.doMove [5;2] [5;0] (Drain 0) = [0;0])

let testDoMoveD2 = 
    Test.make 
    ~name:"Drain test 2"
    ~count:1 unit (fun _ -> Q3.doMove [1;3;5;2] [1;3;5;0] (Drain 2) = [1;3;0;0])

let testDoMoveD3 = 
    Test.make 
    ~name:"Drain test 3"
    ~count:1 unit (fun _ -> Q3.doMove [1;3;5;2] [1;3;5;0] (Drain 3) = [1;3;5;0])

let testCheck1 = 
    Test.make 
    ~name:"Check test 1"
    ~count:1 unit (fun _ -> Q3.check 4 [] = false)

let testCheck2 = 
    Test.make 
    ~name:"Check test 2"
    ~count:1 unit (fun _ -> Q3.check 4 [1;2;3] = false)

let testCheck3 = 
    Test.make 
    ~name:"Check test 3"
    ~count:1 unit (fun _ -> Q3.check 4 [1;4;2;3] = true)

let testRun1 = 
    Test.make 
    ~name:"Run test 1"
    ~count:1 unit (fun _ -> Q3.run [5;2] 1 [Fill 0; Transfer (0,1); Drain 1; Transfer (0,1)] = true)

let testRun2 = 
    Test.make 
    ~name:"Run test 2"
    ~count:1 unit (fun _ -> Q3.run [5;2] 1 [Fill 0; Transfer (0,1); Drain 1; Transfer (0,1); Drain 0] = false)

let testRun3 = 
    Test.make 
    ~name:"Run test 3"
    ~count:1 unit (fun _ -> Q3.run [5;2] 1 [Fill 0; Transfer (0,1); Transfer (0,1)] = false)

let n3 = QCheck_runner.run_tests ~out:stdout
  [ testDoMoveT1
  ; testDoMoveT2
  ; testDoMoveT3
  ; testDoMoveF1
  ; testDoMoveF2
  ; testDoMoveF3
  ; testDoMoveD1
  ; testDoMoveD2
  ; testDoMoveD3
  ; testCheck1
  ; testCheck2
  ; testCheck3
  ; testRun1
  ; testRun2
  ; testRun3
  ; testSelf
  ]

(* error code is the number of failed/errored tests *)
let _ = print_int (n1 + n2 + n3); exit n1 + n2 + n3
