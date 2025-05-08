# OCaml Functional Programming Coursework

This repository contains solutions for various problems related to functional programming in OCaml, focusing on list operations, recursion, and problem-solving with functional paradigms.

## **Contents**

1. **Question 1: List Operations and Predicates**
   - **Problem Overview**: The task involves implementing common list operations such as filtering, folding, and predicate-based checking.
   - **Functions Implemented**:
     - `filter`: Filters a list based on a predicate.
     - `foldLeft`: Applies a function to a list with an accumulator in a left-associative manner.
     - `all`: Checks if all elements in a list satisfy a predicate.
     - `exists`: Checks if any element in a list satisfies a predicate.
     - `allF`: Similar to `all` but processes the entire list, even if a mismatch is found earlier.
     - `member`: Checks if an element exists in a list.
     - `allSpec`: Checks if all elements in the list satisfy a predicate.
     - `existsSpec`: Checks if there exists an element that satisfies the predicate.

2. **Question 2: Sorting and List Operations**
   - **Problem Overview**: The task involves sorting a list using a recursive approach.
   - **Functions Implemented**:
     - `extractMin`: Extracts the minimum element from a list.
     - `extractSort`: Recursively sorts a list by repeatedly extracting the minimum element.
     - `check`: Checks if a list contains a specific amount.
     - `run`: Runs a series of jar manipulation moves and checks if any jar contains a specified amount of liquid.

3. **Question 3: State-Based Problem Solving**
   - **Problem Overview**: This question involves simulating the filling, draining, and transferring of liquids between jars and solving a problem by applying a series of operations.
   - **Functions Implemented**:
     - `doMove`: Performs a move on the jars (filling, draining, or transferring liquid).
     - `runMoves`: Applies a series of moves to a list of jars.
     - `check`: Checks if a jar contains a certain amount of liquid after a series of moves.
     - `solve`: (To be implemented) Placeholder for solving a specific problem with the jar operations.

---

## **Detailed Explanation**

### **Question 1: List Operations and Predicates**

#### `filter p lst`
Filters a list `lst` by applying the predicate function `p`. Elements for which `p` returns `true` are included in the result.

#### `foldLeft f acc lst`
Applies the function `f` to each element of the list `lst` with an accumulator `acc`. This function is implemented recursively.

#### `all p xs`
Checks if all elements in the list `xs` satisfy the predicate `p`. The recursion stops as soon as a mismatch is found.

#### `exists p xs`
Checks if at least one element in the list `xs` satisfies the predicate `p`. It uses `foldLeft` to accumulate the result.

#### `allF p xs`
Like `all`, but processes every element even if an early mismatch is found. It ensures that the entire list is processed.

#### `member x xs`
Checks if an element `x` exists in the list `xs`. This is done recursively, looking for a match at each step.

#### `allSpec p xs`
Checks if every element in `xs` is a member of the list of elements that satisfy the predicate `p`.

#### `existsSpec p xs`
Checks if there exists at least one element in `xs` that satisfies the predicate `p` and is a member of the list of elements satisfying `p`.

---

### **Question 2: Sorting and List Operations**

#### `extractMin xs`
Finds the minimum element in the list `xs` and returns it along with the rest of the list.

#### `extractSort xs`
Sorts the list `xs` by repeatedly extracting the minimum element and building a sorted list.

#### `check amount contents`
Checks if any jar in the list `contents` holds the specified `amount` of liquid.

#### `run sizes amount moves`
Simulates a series of jar operations, checking if any jar contains the specified `amount` of liquid at the end.

---

### **Question 3: State-Based Problem Solving**

#### `doMove sizes contents move`
Performs a specified operation (fill, drain, or transfer) on a list of jars `contents` with the given `sizes`.

#### `runMoves contents moves`
Applies a list of moves to the `contents` of the jars, updating the contents at each step.

#### `check amount contents`
Checks if any jar contains the specified `amount` after a series of moves.

#### `solve sizes amount`
This function is a placeholder for solving a specific problem, like determining the steps to achieve a certain amount of liquid in a jar.

---

## **Usage Instructions**

1. **Compiling and Running OCaml Code**:
   To run the code, you need OCaml installed on your machine. If you haven't installed it, follow the instructions on the official OCaml website: [https://ocaml.org/](https://ocaml.org/).

   Once you have OCaml installed, you can compile the files using the `ocamlc` command:
   
   ```bash
   ocamlc -o question1 question1.ml
   ocamlc -o question2 question2.ml
   ocamlc -o question3 question3.ml

Then, you can run the programs using the OCaml interpreter:
```bash
./question1
./question2
./question3
```
Testing the Functions:
You can call the functions defined in each file to test their behavior. For example, in question1.ml, you can test the all and exists functions on different lists and predicates.
