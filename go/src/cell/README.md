Using goroutine
===============

With this algorithm I wanted to learn how to use goroutine.

-----------------------------

global
------

The algorithm I thought of was going through the sudoku.

Each time a cell is empty I give it a goroutine.


Here is a sudoku grid I'll take as exemple =>

| _ | 3 | _ | 9 | 1 | 7 | _ | 2 | _ |
|---|---|---|---|---|---|---|---|---|
| _ | _ | _ | _ | 6 | 3 | 9 | _ | _ |
| _ | 9 | 6 | 2 | _ | _ | _ | _ | 8 |
| _ | _ | _ | _ | 5 | 2 | _ | 9 | 7 |
| 6 | 7 | _ | _ | _ | _ | _ | 5 | 4 |
| 2 | 8 | _ | 4 | 7 | _ | _ | _ | _ |
| 9 | _ | _ | _ | _ | 4 | 5 | 6 | _ |
| _ | _ | 7 | 1 | 3 | _ | _ | _ | _ |
| _ | 6 | _ | 5 | 9 | 8 | _ | 7 | _ |

There is 45 unattributed cells (one for each '_') and so there will be 45 goroutine.

It'll then wait for each one to finish

goroutine
---------

Each goroutine will start by creating a slice containing all the possible number for it's position.
The first one will start with a slice containing {1, 2, 3, 4, 5, 6, 7, 8, 9} and will then remove all the element that cannot fit here => {4, 5, 8}.


Then the goroutine will wait 100ms to let the other works and check back if one of the number it still have can be removed.

When it have only one possible number it put it in the grid and exit.


------------------------

This algorithm is fucked and can't finish, when applied to the grid showed in example it's solve a part of the grid and then block here =>


| _ | 3 | _ | 9 | 1 | 7 | _ | 2 | _ |
|---|---|---|---|---|---|---|---|---|
| _ | _ | _ | 8 | 6 | 3 | 9 | _ | _ |
| _ | 9 | 6 | 2 | 4 | 5 | _ | _ | 8 |
| _ | 4 | _ | 6 | 5 | 2 | _ | 9 | 7 |
| 6 | 7 | _ | 3 | 8 | _ | _ | 5 | 4 |
| 2 | 8 | _ | 4 | 7 | _ | _ | _ | _ |
| 9 | 1 | 8 | 7 | 2 | 4 | 5 | 6 | 3 |
| _ | _ | 7 | 1 | 3 | 6 | _ | _ | _ |
| _ | 6 | _ | 5 | 9 | 8 | _ | 7 | _ |

You can see there is still a lot of unsolved cells.

But if we take the first bloc we can easily see that the only spot where the 8 can come is the first cell.
So now my idea is to create a new branch adding one goroutine per bloc which will coordinate all the 9 goroutine in it's bloc.
