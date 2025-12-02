defmodule Aoc.DayOne do
  def parse(<<"R", num::binary>>), do: String.to_integer(num)
  def parse(<<"L", num::binary>>), do: -1 * String.to_integer(num)

  def rotate(delta, dial) do
    Integer.mod(delta + dial, 100)
  end

  def get_clicks(delta, dial) do
    sum = dial + rem(delta, 100)
    rotations = div(abs(delta), 100)

    case 1 do
      _ when dial != 0 and (sum <= 0 or sum >= 100) -> rotations + 1
      _ -> rotations
    end
  end

  def reduce_part_one(line, {acc, count}) do
    result =
      line
      |> String.trim()
      |> Aoc.DayOne.parse()
      |> Aoc.DayOne.rotate(acc)

    case result do
      0 -> {0, count + 1}
      _ -> {result, count}
    end
  end

  def reduce_part_two(line, {dial, count}) do
    delta =
      line
      |> String.trim()
      |> Aoc.DayOne.parse()

    {Aoc.DayOne.rotate(delta, dial), count + Aoc.DayOne.get_clicks(delta, dial)}
  end

  def part_one(path) do
    {_, result} =
      File.stream!(path)
      |> Enum.reduce({50, 0}, &Aoc.DayOne.reduce_part_one/2)

    result
  end

  def part_two(path) do
    {_, result} =
      File.stream!(path)
      |> Enum.reduce({50, 0}, &Aoc.DayOne.reduce_part_two/2)

    result
  end
end
