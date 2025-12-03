defmodule Aoc.DayTwo do
  defp parse(range) when is_binary(range) do
    [start_str, finish_str] = String.split(range, "-")
    {String.to_integer(start_str), String.to_integer(finish_str)}
  end

  defp parse(_), do: {:error, :invalid_format}

  defp repeat2?(bin) when is_binary(bin) do
    len = byte_size(bin)

    case rem(len, 2) do
      0 ->
        half = div(len, 2)
        <<x::binary-size(half), x::binary-size(half)>> = bin
        true

      _ ->
        false
    end
  rescue
    MatchError -> false
  end

  defp pattern_checker(bin, counter, len) do
    symbols = counter + 1

    rem(len, symbols) == 0 and
      String.count(bin, String.slice(bin, 0..counter)) == div(len, symbols)
  end

  defp repeat?(bin, counter, len) when is_binary(bin) do
    cond do
      counter == -1 -> false
      pattern_checker(bin, counter, len) -> true
      true -> repeat?(bin, counter - 1, len)
    end
  end

  defp reduce_part_one(range, count) do
    {start, finish} = parse(range)

    Enum.reduce(start..finish, count, fn id, acc ->
      case repeat2?(Integer.to_string(id)) do
        true -> acc + id
        false -> acc
      end
    end)
  end

  # Eh. Just brute force it
  defp reduce_part_two(range, count) do
    {start, finish} = parse(range)

    Enum.reduce(start..finish, count, fn id, acc ->
      id_str = Integer.to_string(id)
      len = byte_size(id_str)

      case repeat?(id_str, div(len, 2) - 1, len) do
        true -> acc + id
        false -> acc
      end
    end)
  end

  def part_one(path) do
    File.read!(path)
    |> String.trim()
    |> String.split(",")
    |> Enum.reduce(0, &reduce_part_one/2)
  end

  def part_two(path) do
    File.read!(path)
    |> String.trim()
    |> String.split(",")
    |> Enum.reduce(0, &reduce_part_two/2)
  end
end
