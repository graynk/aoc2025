defmodule Aoc.DaySeven do
  defp find_all_occurence_indexes(<<char::utf8, rest::binary>>, index, value, list)
       when char == value do
    find_all_occurence_indexes(rest, index + 1, value, [index | list])
  end

  defp find_all_occurence_indexes(<<_::utf8, rest::binary>>, index, value, list) do
    find_all_occurence_indexes(rest, index + 1, value, list)
  end

  defp find_all_occurence_indexes("", _, _, list) do
    list
  end

  defp replace_indexes(<<char::utf8, rest::binary>>, index, indexes, acc) do
    replacement =
      if MapSet.member?(indexes, index) do
        "|"
      else
        <<char::utf8>>
      end

    replace_indexes(rest, index + 1, indexes, [replacement | acc])
  end

  defp replace_indexes(_, _, _, acc) do
    Enum.reverse(acc) |> IO.iodata_to_binary()
  end

  defp reduce_part_one(line, {set, count}) do
    indexes = find_all_occurence_indexes(line, 0, ?^, [])

    count =
      Enum.reduce(indexes, count, fn idx, acc ->
        if MapSet.member?(set, idx) do
          acc + 1
        else
          acc
        end
      end)

    set =
      for i <- indexes,
          i > 0,
          i < String.length(line) - 1 do
        [i - 1, i + 1]
      end
      |> List.flatten()
      |> Enum.reduce(set, fn idx, acc_set -> MapSet.put(acc_set, idx) end)

    set = Enum.reduce(indexes, set, fn idx, acc_set -> MapSet.delete(acc_set, idx) end)
    # IO.puts(replace_indexes(line, 0, set, []))

    {set, count}
  end

  def part_one(path) do
    contents =
      path
      |> File.read!()
      |> String.split("\n")
      |> Enum.drop(-1)

    # IO.puts(List.first(contents))

    initial_set =
      contents
      |> List.first()
      |> find_all_occurence_indexes(0, ?S, [])
      |> MapSet.new()

    {_, count} =
      contents
      |> Enum.drop(1)
      |> Enum.reduce({initial_set, 0}, &reduce_part_one/2)

    count
  end

  # def part_two(path) do
  #   File.stream!(path)
  #   |> Enum.map(&String.trim/1)
  #   |> Enum.filter(fn line -> line != "" end)
  #   |> Enum.reduce(0, &reduce_part_two/2)
  # end
end
