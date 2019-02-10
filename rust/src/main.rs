// use std::fs::File;
// use std::env;

mod utils;
mod solver;

pub const SIZE: usize = 9;

fn main() {
    let mut grid = utils::parse();
    utils::dump_table(grid);

    if !solver::solve(&mut grid, 0, 0) {
        println!("Your grid cannot be solved");
    } else {
        println!("Solved grid :");
    }

    utils::dump_table(grid);
}
