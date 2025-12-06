defmodule Aoc.DaySixTest do
  use ExUnit.Case, async: true

  test "first part works on the test input" do
    assert Aoc.DaySix.part_one("test/fixtures/day_six/testinput.txt") == 4_277_556
  end

  test "first part works on the actual input" do
    assert Aoc.DaySix.part_one("test/fixtures/day_six/input.txt") == 5_524_274_308_182
  end

  test "second part works on the test input" do
    assert Aoc.DaySix.part_two("test/fixtures/day_six/testinput.txt") == 3_263_827
  end

  test "second part works on the actual input" do
    assert Aoc.DaySix.part_two("test/fixtures/day_six/input.txt") == 8_843_673_199_391
  end
end
