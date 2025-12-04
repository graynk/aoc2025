defmodule Aoc.DayFourTest do
  use ExUnit.Case, async: true

  test "first part works on the test input" do
    assert Aoc.DayFour.part_one("test/fixtures/day_four/testinput.txt") == 13
  end

  test "first part works on the actual input" do
    assert Aoc.DayFour.part_one("test/fixtures/day_four/input.txt") == 1437
  end

  test "second part works on the test input" do
    assert Aoc.DayFour.part_two("test/fixtures/day_four/testinput.txt") == 43
  end

  test "second part works on the actual input" do
    assert Aoc.DayFour.part_two("test/fixtures/day_four/input.txt") == 8765
  end
end
