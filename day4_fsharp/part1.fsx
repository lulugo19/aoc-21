open System

type Bingo = (int * bool)[][]

let parseBingo (s : string) = 
  s.Split("\r\n", StringSplitOptions.RemoveEmptyEntries) |> 
  Array.map(fun row -> row.Split(" ", StringSplitOptions.RemoveEmptyEntries) |> Array.map(fun n -> (int(n), false)))

let evalBingo (bingo: Bingo) : bool =
  let l = bingo.Length
  let rows = seq {0 .. l-1} |> Seq.exists (fun i -> seq{0 .. l-1} |> Seq.forall (fun j -> snd bingo.[i].[j]))
  let cols = seq {0 .. l-1} |> Seq.exists (fun i -> seq{0 .. l-1} |> Seq.forall (fun j -> snd bingo.[j].[i]))
  rows || cols

let bingoRound (number: int) (bingo: Bingo) : Bingo =
  bingo |> Array.map(fun row -> row |> Array.map(fun (x, b) -> if x = number then (x, true) else (x, b)))
  
let rec playBingo (numbers: int list) (bingos: Bingo list) =
  match numbers with
  | [] -> Error "No Winner"
  | x::xs -> 
    let next_bingos = bingos |> List.map (bingoRound x)
    let has_winner = next_bingos |> List.exists(evalBingo)
    if has_winner then Ok ((List.find evalBingo next_bingos, x)) else playBingo xs next_bingos
    
let input = "input.txt" |> System.IO.File.ReadAllText
let items = input.Split("\r\n\r\n", StringSplitOptions.RemoveEmptyEntries)
let numbers = items.[0].Split(",", StringSplitOptions.RemoveEmptyEntries) |> Array.map(int) |> Array.toList
let bingos = items.[1..] |> Array.map(parseBingo) |> Array.toList

match playBingo numbers bingos with
  | Ok (winner, number) -> 
    let sum = winner |> Array.fold (fun acc row -> acc + (row |> Array.filter (fun (_, b) -> not b) |> Array.map fst |> Array.sum)) 0
    let result = sum * number
    printfn "%A" result
  | _ -> printfn "No winner"