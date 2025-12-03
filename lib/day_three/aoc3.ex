defmodule Aoc.DayThree do
  defp sum_chars({a, b}) do
    String.to_integer(<<a::utf8, b::utf8>>)
  end

  defp search(<<char::utf8, rest::binary>>, {0, 0}) do
    search(rest, {char, 0})
  end

  defp search(<<char::utf8, rest::binary>>, {a, b})
       when b > a do
    search(rest, {b, char})
  end

  defp search(<<char::utf8, rest::binary>>, {a, b})
       when char > b do
    search(rest, {a, char})
  end

  defp search(<<_::utf8, rest::binary>>, current_result) do
    search(rest, current_result)
  end

  defp search("", current_result) do
    sum_chars(current_result)
  end

  defp reduce_part_one(line, sum) do
    sum + search(line, {0, 0})
  end

  # Eh. Just brute force it

  def part_one(path) do
    File.stream!(path)
    |> Enum.map(fn line -> String.trim(line) end)
    |> Enum.filter(fn line -> line != "" end)
    |> Enum.reduce(0, &reduce_part_one/2)
  end

  # def part_two(path) do
  #   File.stream!(path)
  #   |> Enum.map(fn line -> String.trim(line) end)
  #   |> Enum.filter(fn line -> line != "" end)
  #   |> Enum.reduce(0, &reduce_part_one/2)
  # end
end
