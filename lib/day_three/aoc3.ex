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
       when char > max_char and byte_size(rest) >= 12 - n do
    find_largest_char(rest, {current_index, char}, current_index + 1, n)
  end

  defp find_largest_char(<<char::utf8, _::binary>>, {_, max_char}, current_index, _)
       when char > max_char do
    {current_index, char}
  end

  defp find_largest_char(<<_::utf8, rest::binary>>, {max_index, max_char}, current_index, n)
       when byte_size(rest) >= 12 - n do
    find_largest_char(rest, {max_index, max_char}, current_index + 1, n)
  end

  defp find_largest_char(_, result, _, _) do
    result
  end

  defp search_twelve(_, chars) when length(chars) == 12 do
    sum_chars(chars)
  end

  defp search_twelve(string, chars) do
    {index, char} = find_largest_char(string, {0, 0}, 0, length(chars))
    search_twelve(binary_slice(string, (index + 1)..byte_size(string)), chars ++ [char])
  end

  defp reduce_part_two(line, sum) do
    sum + search_twelve(line, [])
  end

  def part_one(path) do
    File.stream!(path)
    |> Enum.map(&String.trim/1)
    |> Enum.filter(fn line -> line != "" end)
    |> Enum.reduce(0, &reduce_part_one/2)
  end

  def part_two(path) do
    File.stream!(path)
    |> Enum.map(&String.trim/1)
    |> Enum.filter(fn line -> line != "" end)
    |> Enum.reduce(0, &reduce_part_two/2)
  end
end
