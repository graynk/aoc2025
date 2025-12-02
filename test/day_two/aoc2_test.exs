defmodule Aoc.DayTwoTest do
  use ExUnit.Case, async: true

  test "first part works on the test input" do
    assert Aoc.DayTwo.part_one("test/fixtures/day_two/testinput.txt") ==
             1_227_775_554
  end

  test "first part works on the actual input" do
    assert Aoc.DayTwo.part_one("test/fixtures/day_two/input.txt") ==
             34_826_702_005
  end

  test "second part works on the test input" do
    assert Aoc.DayTwo.part_two("test/fixtures/day_two/testinput.txt") ==
             4_174_379_265
  end

  test "second part works on the actual input" do
    assert Aoc.DayTwo.part_two("test/fixtures/day_two/input.txt") ==
             43_287_141_963
  end
end
