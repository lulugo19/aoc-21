defmodule AOC_Day8 do
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

  def part1 do
    parse()
    |> Enum.map(fn {_, outputs} ->
      Enum.count(outputs, fn o -> Enum.member?([2, 4, 3, 7], String.length(o)) end)
    end)
    |> Enum.sum()
  end
end

IO.puts(AOC_Day8.part1())
