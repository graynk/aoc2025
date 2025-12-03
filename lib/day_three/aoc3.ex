defmodule Aoc.DayThree do
  defp sum_chars({a, b}) do
    String.to_integer(<<a::utf8, b::utf8>>)
  end

  defp sum_chars(list) do
    str = Enum.map_join(list, fn char -> <<char::utf8>> end)
    String.to_integer(str)
  end

  # Part one

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

  # Part two

  defp find_largest_char(<<char::utf8, rest::binary>>, {_, max_char}, current_index, n)
       when char > max_char do
    if String.length(rest) >= 12 - n do
      find_largest_char(rest, {current_index, char}, current_index + 1, n)
    else
      {current_index, char}
    end
  end

  defp find_largest_char(<<_::utf8, rest::binary>>, {max_index, max_char}, current_index, n) do
    if String.length(rest) >= 12 - n do
      find_largest_char(rest, {max_index, max_char}, current_index + 1, n)
    else
      {max_index, max_char}
    end
  end

  defp find_largest_char("", {max_index, max_char}, _, _) do
    {max_index, max_char}
  end

  defp search_twelve(_, chars) when length(chars) == 12 do
    sum_chars(chars)
  end

  defp search_twelve(string, chars) do
    {index, char} = find_largest_char(string, {0, 0}, 0, length(chars))
    search_twelve(String.slice(string, (index + 1)..String.length(string)), chars ++ [char])
  end

  defp reduce_part_two(line, sum) do
    sum + search_twelve(line, [])
  end

  def part_one(path) do
    File.stream!(path)
    |> Enum.map(fn line -> String.trim(line) end)
    |> Enum.filter(fn line -> line != "" end)
    |> Enum.reduce(0, &reduce_part_one/2)
  end

  def part_two(path) do
    File.stream!(path)
    |> Enum.map(fn line -> String.trim(line) end)
    |> Enum.filter(fn line -> line != "" end)
    |> Enum.reduce(0, &reduce_part_two/2)
  end
end
