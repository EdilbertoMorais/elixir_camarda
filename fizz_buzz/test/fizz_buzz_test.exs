defmodule FizzBuzzTest do
  use ExUnit.Case

  describe "build/1" do
    test "when a valid file is provided, returns the converted list" do
      expected_response =
      {:ok, [1, 2, :fizz, 4, :buzz, :fizz, 7, 8, :fizz, :buzz, 11, :fizz, 13, 14, 
      :fizzbuzz, 16, 17, :fizz, 19, :buzz, :fizz, 22, 23, :fizz, :buzz, 26, :fizz, 28, 29, :fizzbuzz]}

      assert FizzBuzz.build("numbers.txt") == expected_response
    end

    test "when an invalid file is provided, returns an error" do
      expected_response = {:error, "Error reading the file: enoent"}

      assert FizzBuzz.build("invalid.txt") == expected_response
    end
  end
end
