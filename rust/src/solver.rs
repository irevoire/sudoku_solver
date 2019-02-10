use crate::SIZE;
use crate::utils::{hash, hash_bloc, Grid};

fn find_cell(grid: Grid, x: &mut usize, y: &mut usize) -> bool {
    while *y < SIZE {
        while *x < SIZE {
            if grid[hash(*x, *y)] == None {
                return false;
            }
            *x += 1;
        }
        *x = 0;
        *y += 1;
    }

    return true;
}

fn include(grid: Grid, x: usize, y: usize, val: u8) -> bool {
    for n in 0..SIZE {
        if grid[hash(n, y)] == Some(val) { return true };
        if grid[hash(x, n)] == Some(val) { return true };
        if grid[hash_bloc(x, y, n)] == Some(val) { return true };
    }

    return false;
}

pub fn solve(grid: &mut Grid, mut x: usize, mut y: usize) -> bool {
    if find_cell(*grid, &mut x, &mut y) { return true };

    for i in 1..(SIZE + 1) as u8 {
        if include(*grid, x, y, i) { continue };

        grid[hash(x, y)] = Some(i);

        if x == SIZE - 1 {
            if solve(grid, 0, y + 1) { return true };
        } else {
            if solve(grid, x + 1, y) { return true };
        }
    }

	// we are going to backtrack
	grid[hash(x, y)] = None;

    return false;
}
