defmodule AOC_Day8 do
  def permutations([]), do: [[]]

  def permutations(list),
    do: for(elem <- list, rest <- permutations(list -- [elem]), do: [elem | rest])

  def parse do
    File.read!("input.txt")
    |> String.split(["\n", "\r", "\r\n"])
    |> Enum.map(fn str ->
      [inputs, outputs] =
        String.split(str, " | ")
        |> Enum.map(fn str -> String.split(str, " ") end)

      {inputs, outputs}
    end)
  end

  def deduct(inputs) do
    one = inputs |> Enum.find(fn x -> String.length(x) == 2 end)
    four = inputs |> Enum.find(fn x -> String.length(x) == 4 end)
    joined_inputs = Enum.join(inputs) |> String.graphemes()

    permutations(["a", "b", "c", "d", "e", "f", "g"])
    |> Enum.find(fn p ->
      p |> Enum.map(fn x -> joined_inputs |> Enum.count(&(&1 == x)) end) == [8, 6, 8, 7, 4, 9, 7] and
        not String.contains?(one, Enum.at(p, 0)) and not String.contains?(four, Enum.at(p, 6))
    end)
  end

  def decode(segments, outputs) do
    outputs
    |> Enum.map(fn o ->
      indices =
        Enum.map(String.to_charlist(o), fn x ->
          Enum.find_index(segments, fn y -> y == List.to_string([x]) end)
        end)
        |> Enum.sort()

      Enum.find_index(
        [
          [0, 1, 2, 4, 5, 6],
          [2, 5],
          [0, 2, 3, 4, 6],
          [0, 2, 3, 5, 6],
          [1, 2, 3, 5],
          [0, 1, 3, 5, 6],
          [0, 1, 3, 4, 5, 6],
          [0, 2, 5],
          [0, 1, 2, 3, 4, 5, 6],
          [0, 1, 2, 3, 5, 6]
        ],
        fn x -> x == indices end
      )
      |> Integer.to_string()
    end)
    |> Enum.join()
    |> String.to_integer()
  end

  def part2 do
    parse()
    |> Enum.map(fn {inputs, outputs} -> deduct(inputs) |> decode(outputs) end)
    |> Enum.sum()
  end
end

IO.inspect(AOC_Day8.part2())
