#!/usr/bin/env bash
# Purely vibe-coded

set -e

# Input is now an integer like: 1, 2, 3, 4...
NUMBER="$1"

if ! [[ "$NUMBER" =~ ^[0-9]+$ ]]; then
  echo "Please provide a number (e.g. 4)"
  exit 1
fi

WORDS=(zero one two three four five six seven eight nine ten)

WORD="${WORDS[$NUMBER]}"

if [ -z "$WORD" ]; then
  echo "Number out of supported range: $NUMBER"
  exit 1
fi

if [ -z "$COOKIE" ]; then
  echo "Error: COOKIE environment variable not set."
  exit 1
fi

# Capitalize for module name
CAP="${WORD^}"

# Create directories
mkdir -p "lib/day_$WORD"
mkdir -p "test/day_$WORD"
mkdir -p "test/fixtures/day_$WORD"

# Create code file
CODE_FILE="lib/day_$WORD/aoc${NUMBER}.ex"
cat > "$CODE_FILE" <<EOF
defmodule Aoc.Day${CAP} do
  defp reduce_part_one(line, sum) do
  end

  defp reduce_part_two(line, sum) do
  end

  def part_one(path) do
    File.stream!(path)
    |> Enum.map(&String.trim/1)
    |> Enum.filter(fn line -> line != "" end)
    |> Enum.reduce(0, &reduce_part_one/2)
  end

  def part_two(path) do
    File.stream!(path)
    |> Enum.map(&String.trim/1)
    |> Enum.filter(fn line -> line != "" end)
    |> Enum.reduce(0, &reduce_part_two/2)
  end
end
EOF

# Create test file
TEST_FILE="test/day_$WORD/aoc${NUMBER}_test.exs"
cat > "$TEST_FILE" <<EOF
defmodule Aoc.Day${CAP}Test do
  use ExUnit.Case, async: true
end
EOF

# Download input
INPUT_URL="https://adventofcode.com/2025/day/${NUMBER}/input"
INPUT_FILE="test/fixtures/day_${WORD}/input.txt"

wget --quiet \
  --header="Cookie: session=$COOKIE" \
  -O "$INPUT_FILE" \
  "$INPUT_URL"

echo "Created:"
echo "  $CODE_FILE"
echo "  $TEST_FILE"
echo "Downloaded input to:"
echo "  $INPUT_FILE"
