defmodule Aoc.DaySix do
  defp reduce_part_one(["+" | rest_str], {[column | rest_col], sum}) do
    reduce_part_one(rest_str, {rest_col, sum + Enum.sum(column)})
  end

  defp reduce_part_one(["*" | rest_str], {[column | rest_col], sum}) do
    reduce_part_one(rest_str, {rest_col, sum + Enum.product(column)})
  end

  defp reduce_part_one([], {[], sum}) do
    sum
  end

  defp reduce_part_one(line, {[], _}) do
    numbers =
      line
      |> Enum.map(fn number_str -> [String.to_integer(number_str)] end)

    {numbers, 0}
  end

  defp reduce_part_one(line, {columns, _}) do
    numbers =
      line
      |> Enum.map(fn number_str -> String.to_integer(number_str) end)

    {append_to_columns(columns, numbers, []), 0}
  end

  defp append_to_columns([column | rest_col], [number | rest_num], result) do
    append_to_columns(rest_col, rest_num, result ++ [column ++ [number]])
  end

  defp append_to_columns([], [], result) do
    result
  end

  defp column_to_int(column) do
    column
    |> Enum.filter(fn char -> char != " " end)
    |> Enum.join()
    |> String.to_integer()
  end

  defp construct_columns(graphemes, []) do
    graphemes
    |> Enum.map(fn grapheme -> [grapheme] end)
  end

  defp construct_columns(graphemes, columns) do
    append_to_columns(columns, graphemes, [])
  end

  defp pad_operators([operator | rest], prev_operator, padded) do
    case operator do
      " " -> pad_operators(rest, prev_operator, padded ++ [prev_operator])
      _ -> pad_operators(rest, operator, padded ++ [operator])
    end
  end

  defp pad_operators([], _, padded) do
    padded
  end

  defp reduce_part_two([column | rest_col], [operator | rest_op], sum, acc) do
    cond do
      Enum.all?(column, &Kernel.==(&1, " ")) ->
        reduce_part_two(rest_col, rest_op, sum + acc, 0)

      operator == "+" ->
        reduce_part_two(rest_col, rest_op, sum, acc + column_to_int(column))

      operator == "*" and acc == 0 ->
        reduce_part_two(rest_col, rest_op, sum, column_to_int(column))

      operator == "*" ->
        reduce_part_two(rest_col, rest_op, sum, acc * column_to_int(column))
    end
  end

  defp reduce_part_two([], [], sum, acc) do
    sum + acc
  end

  def part_one(path) do
    File.stream!(path)
    |> Enum.map(fn line -> line |> String.trim() |> String.split(" ", trim: true) end)
    |> Enum.filter(fn line -> line != [""] end)
    |> Enum.reduce({[], 0}, &reduce_part_one/2)
  end

  def part_two(path) do
    contents =
      path
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)
      |> Enum.drop(-1)

    operators = contents |> List.last() |> pad_operators("", [])

    columns =
      contents
      |> Enum.drop(-1)
      |> Enum.reduce([], &construct_columns/2)

    reduce_part_two(columns, operators, 0, 0)
  end
end
