defmodule Aoc.DayOneTest do
  use ExUnit.Case, async: true

  test "first part works on the test input" do
    assert Aoc.DayOne.part_one("test/fixtures/day_one/testinput.txt") == 3
  end

  test "first part works on the actual input" do
    assert Aoc.DayOne.part_one("test/fixtures/day_one/input.txt") == 964
  end

  test "second part works on the test input" do
    assert Aoc.DayOne.part_two("test/fixtures/day_one/testinput.txt") == 6
  end

  test "second part works on the actual input" do
    assert Aoc.DayOne.part_two("test/fixtures/day_one/input.txt") == 5872
  end
end
