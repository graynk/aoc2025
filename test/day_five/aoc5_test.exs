defmodule Aoc.DayFiveTest do
  use ExUnit.Case, async: true

  test "first part works on the test input" do
    assert Aoc.DayFive.part_one("test/fixtures/day_five/testinput.txt") == 3
  end

  test "first part works on the actual input" do
    assert Aoc.DayFive.part_one("test/fixtures/day_five/input.txt") == 643
  end

  test "second part works on the test input" do
    assert Aoc.DayFive.part_two("test/fixtures/day_five/testinput.txt") == 14
  end

  test "second part works on the actual input" do
    assert Aoc.DayFive.part_two("test/fixtures/day_five/input.txt") == 342_018_167_474_526
  end
end
