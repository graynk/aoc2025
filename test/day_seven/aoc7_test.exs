defmodule Aoc.DaySevenTest do
  use ExUnit.Case, async: true

  test "first part works on the test input" do
    assert Aoc.DaySeven.part_one("test/fixtures/day_seven/testinput.txt") == 21
  end

  test "first part works on the actual input" do
    assert Aoc.DaySeven.part_one("test/fixtures/day_seven/input.txt") == 1518
  end
end
