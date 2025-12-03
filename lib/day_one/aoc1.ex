defmodule Aoc.DayOne do
  defp parse(<<"R", num::binary>>), do: String.to_integer(num)
  defp parse(<<"L", num::binary>>), do: -1 * String.to_integer(num)

  defp rotate(delta, dial) do
    Integer.mod(delta + dial, 100)
  end

  defp get_clicks(delta, dial) do
    sum = dial + rem(delta, 100)
    rotations = div(abs(delta), 100)

    case 1 do
      _ when dial != 0 and (sum <= 0 or sum >= 100) -> rotations + 1
      _ -> rotations
    end
  end

  defp reduce_part_one(line, {acc, count}) do
    result =
      line
      |> String.trim()
      |> parse()
      |> rotate(acc)

    case result do
      0 -> {0, count + 1}
      _ -> {result, count}
    end
  end

  defp reduce_part_two(line, {dial, count}) do
    delta =
      line
      |> String.trim()
      |> parse()

    {rotate(delta, dial), count + get_clicks(delta, dial)}
  end

  def part_one(path) do
    {_, result} =
      File.stream!(path)
      |> Enum.map(fn line -> String.trim(line) end)
      |> Enum.filter(fn line -> line != "" end)
      |> Enum.reduce({50, 0}, &reduce_part_one/2)

    result
  end

  def part_two(path) do
    {_, result} =
      File.stream!(path)
      |> Enum.map(fn line -> String.trim(line) end)
      |> Enum.filter(fn line -> line != "" end)
      |> Enum.reduce({50, 0}, &reduce_part_two/2)

    result
  end
end
