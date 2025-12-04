defmodule Aoc.DayFour do
  defp parse(path) do
    matrix =
      File.stream!(path)
      |> Enum.map(&String.trim/1)
      |> Enum.filter(fn line -> line != "" end)
      |> Enum.map(fn line -> line |> String.graphemes() end)

    # |> List.to_tuple()

    m = length(matrix) - 1
    n = matrix |> Enum.at(0) |> length() |> Kernel.-(1)

    {matrix, m, n}
  end

  defp roll_movable?(matrix, x, y, m, n) do
    directions = [
      {-1, -1},
      {-1, 0},
      {-1, 1},
      {0, -1},
      {0, 1},
      {1, -1},
      {1, 0},
      {1, 1}
    ]

    directions
    |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
    |> Enum.filter(fn {nx, ny} -> nx in 0..n and ny in 0..m end)
    |> Enum.map(fn {nx, ny} -> matrix |> Enum.at(ny) |> Enum.at(nx) end)
    |> Enum.count(fn cell -> cell == "@" end)
    |> Kernel.<(4)
  end

  defp get_movable_rolls({matrix, m, n}) do
    for x <- 0..n,
        y <- 0..m do
      cell = matrix |> Enum.at(y) |> Enum.at(x)

      case cell do
        "." ->
          {x, y, false}

        "@" ->
          movable = roll_movable?(matrix, x, y, m, n)
          {x, y, movable}
      end
    end
  end

  defp count_movable_rolls(movable_rolls) do
    Enum.count(movable_rolls, fn {_, _, movable} -> movable end)
  end

  def part_one(path) do
    path
    |> parse()
    |> get_movable_rolls()
    |> count_movable_rolls()
  end

  def update_cell(matrix, x, y, value) do
    List.update_at(matrix, y, fn row ->
      List.update_at(row, x, fn _ -> value end)
    end)
  end

  defp replace_rolls(matrix, movable_rolls) do
    movable_rolls
    |> Enum.reduce(matrix, fn {x, y, movable}, acc_matrix ->
      case movable do
        true -> update_cell(acc_matrix, x, y, ".")
        false -> acc_matrix
      end
    end)
  end

  defp iterate_part_two({matrix, m, n} = input, count) do
    movable_rolls = get_movable_rolls(input)

    case movable = count_movable_rolls(movable_rolls) do
      0 ->
        count

      _ ->
        replaced = replace_rolls(matrix, movable_rolls)
        iterate_part_two({replaced, m, n}, count + movable)
    end
  end

  def part_two(path) do
    path
    |> parse()
    |> iterate_part_two(0)
  end
end
