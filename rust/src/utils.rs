use std::io;
use crate::SIZE;

pub type Grid = [Option<u8>; SIZE * SIZE];

pub fn hash(x: usize, y: usize) -> usize {
	return x * 9 + y
}

pub fn hash_bloc(x: usize, y: usize, n: usize) -> usize {
	let xp = (((x / 3) * 3) + (n % 3)) * 9;
	let yp = ((y / 3) * 3) + (n / 3);

	return xp + yp
}

pub fn dump_table(grid: Grid) {
    println!("{:_<1$}", "", SIZE * 4 + 2);

    let mut y = 0;
    while y < 9 {
        print!("|");

        let mut x = 0;
        while x < 9 {
            print!(" ");
            match grid[hash(x, y)] {
                Some(n) => print!("\x1b[32;1m{}\x1b[m", n),
                None => print!("\x1b[31;1mU\x1b[m"),
            };
            print!(" |");

            x += 1;

            if x % 3 == 0 {
                print!(" ");
            }
        }
        print!("\n");
        y += 1;

        if y % 3 == 0 {
            println!("\x1b[2K");
        }
    }
    println!("\x1b[A{:—<1$}", "", SIZE * 4 + 2);
}

pub fn parse() -> Grid {
    let mut grid: Grid = [Some(0); SIZE * SIZE];
    let mut y: usize = 0;

    loop {
        let mut line = String::new();
        let bytes_read = io::stdin().read_line(&mut line).unwrap();
        if bytes_read == 0 { break }

        for x in 0..SIZE {
            let num = &line[x * 2..(x + 1) * 2 - 1];
            grid[hash(x, y)] = match num.parse() {
                Err(_) => None,
                Ok(n) => Some(n),
            };
        }
        y += 1;
    }
    return grid;
}
