defmodule Aoc.DayThreeTest do
  use ExUnit.Case, async: true

  test "first part works on the test input" do
    assert Aoc.DayThree.part_one("test/fixtures/day_three/testinput.txt") ==
             357
  end

  test "first part works on the actual input" do
    assert Aoc.DayThree.part_one("test/fixtures/day_three/input.txt") ==
             17301
  end

  test "second part works on the test input" do
    assert Aoc.DayThree.part_two("test/fixtures/day_three/testinput.txt") ==
             3_121_910_778_619
  end

  test "second part works on the actual input" do
    assert Aoc.DayThree.part_two("test/fixtures/day_three/input.txt") ==
             172_162_399_742_349
  end
end
