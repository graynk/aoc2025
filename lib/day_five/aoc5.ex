defmodule Aoc.DayFive do
  defp parse(path) do
    [ranges, ids] =
      File.read!(path)
      |> String.split("\n\n")
      |> Enum.map(&String.split(&1, "\n", trim: true))

    ranges =
      ranges
      |> Enum.map(fn str_range ->
        [first, last] =
          str_range
          |> String.split("-")
          |> Enum.map(&String.to_integer(&1))

        Range.new(first, last)
      end)
      |> Enum.sort()

    ranges = merge_ranges(ranges, ranges, [])

    ids = Enum.map(ids, &String.to_integer(&1))

    {ranges, ids}
  end

  defp merge_two_ranges(range, nil) do
    range
  end

  defp merge_two_ranges(nil, range) do
    range
  end

  defp merge_two_ranges(range1, range2) do
    first = min(range1.first, range2.first)
    last = max(range1.last, range2.last)
    Range.new(first, last)
  end

  # Grog merge. Grog merge until no can merge. VERY complex. Grog lazy.
  defp merge_ranges([range | rest], ranges, merged) do
    merged_range =
      ranges
      |> Enum.find(fn other_range ->
        range != other_range and !Range.disjoint?(range, other_range)
      end)
      |> merge_two_ranges(range)

    merge_ranges(rest, ranges, [merged_range | merged])
  end

  defp merge_ranges([], ranges, merged) do
    merged = merged |> Enum.dedup() |> Enum.sort()

    if length(merged) < length(ranges) do
      merge_ranges(merged, merged, [])
    else
      merged
    end
  end

  def count_fresh_ids([id | rest], ranges, sum) do
    if Enum.any?(ranges, fn range -> id in range end) do
      count_fresh_ids(rest, ranges, sum + 1)
    else
      count_fresh_ids(rest, ranges, sum)
    end
  end

  def count_fresh_ids([], _, sum) do
    sum
  end

  def part_one(path) do
    {ranges, ids} = parse(path)

    count_fresh_ids(ids, ranges, 0)
  end

  def part_two(path) do
    {ranges, _} = parse(path)

    ranges
    |> Enum.map(&Range.size/1)
    |> Enum.sum()
  end
end
