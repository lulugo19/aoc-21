use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;
use std::collections::HashSet;

fn main() {
  let mut octopussies: Vec<Vec<i32>> = read_lines("input.txt").unwrap()
    .filter_map(io::Result::ok)
    .map(|s| s.chars().map(|x| x.to_string().parse::<i32>().unwrap()).collect())
    .collect();

  let num_octos = octopussies.len() * octopussies[0].len();

  let mut steps = 0;
  loop {
    steps += 1;
    if step(&mut octopussies) == num_octos {
      break;
    }
  }
  
  println!("{:?}", steps);
}

fn step(octopussies: &mut Vec<Vec<i32>>) -> usize {
  let h = octopussies.len() as i32;
  let w = octopussies[0].len() as i32;

  let mut init_flashed: HashSet<(i32, i32)> = HashSet::new();

  for y in 0..h {
    for x in 0..w {
      octopussies[y as usize][x as usize] += 1;
      if octopussies[y as usize][x as usize] > 9 {
        init_flashed.insert((x, y));
      }
    }
  }

  let mut already_flashed = init_flashed.clone();

  flash(octopussies, init_flashed, &mut already_flashed);

  for y in 0..h {
    for x in 0..w {
      if octopussies[y as usize][x as usize] > 9 {
        octopussies[y as usize][x as usize] = 0;
      }
    }
  }

  return already_flashed.len();
}

fn flash(octopussies: &mut Vec<Vec<i32>>, flashed: HashSet<(i32, i32)>, already_flashed: &mut HashSet<(i32, i32)>) {
  if flashed.len() == 0 {
    return;
  }
  
  let h = octopussies.len() as i32;
  let w = octopussies[0].len() as i32;

  let mut new_flashed: HashSet<(i32, i32)> = HashSet::new();

  for (x, y) in flashed {
    for i in -1i32..=1i32 {
      for j in -1i32..=1i32 {
        if i == 0 && j == 0 {
          continue;
        }
        let ny = y + i;
        let nx = x + j;
        if nx < 0 || ny < 0 || nx >= w || ny >= h {
          continue;
        }
        octopussies[ny as usize][nx as usize] += 1;
        if octopussies[ny as usize][nx as usize] > 9 {
          if !already_flashed.contains(&(nx, ny)) {
            new_flashed.insert((nx, ny));
          }    
        }
      }
    }
  }

  for &(x, y) in &new_flashed {
    already_flashed.insert((x, y));
  }

  flash(octopussies, new_flashed, already_flashed);
}

// The output is wrapped in a Result to allow matching on errors
// Returns an Iterator to the Reader of the lines of the file.
fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>>
where P: AsRef<Path>, {
    let file = File::open(filename)?;
    Ok(io::BufReader::new(file).lines())
}