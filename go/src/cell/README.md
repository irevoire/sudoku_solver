Since I can't solve a sudoku by checking cell per cell if I can input a solution I'll now try doing this a little bit differently.

Here is the best I could do with my last algorithm :

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

Now I'll add a goroutine per bloc to sync all the 9 goroutine (so i'll not have to wait 100ms for nothing) and checking if a number can only be in a certain place.
We are gonna focus on the first bloc and see what we can put in each cells :

| _ | 3 | _ |
|---|---|---|
| _ | _ | _ |
| _ | 9 | 6 |

In the first cell we can put {4, 5, 8}, in the second cell (right after the "3") {4, 5} and etc until we come to something like that :

| (4 5 **8**) | 3     | (4 5)     |
|-------------|-------|-----------|
| (1 4 5 7)   | (2 5) | (1 2 4 5) |
| (1 7)       | 9     | 6         |

Here we can see the only place where we can put the 8 is in the first cell, so the goroutine handling the whole bloc should force the 8 into the first cell and kill the goroutine working on it.

| 8 | 3 | _ |
|---|---|---|
| _ | _ | _ |
| _ | 9 | 6 |

I have no idea if this algorithm can totally solve a sudoku, I don't think so but it seems fun to implement so I'm gonna do it.

