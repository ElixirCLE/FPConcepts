defmodule MapReduceFilterTest do
  use ExUnit.Case
  doctest MapReduceFilter

	require Integer

  test "map" do
		numbers = [1, 2, 3]
		assert MapReduceFilter.naive_map(numbers, fn(x) -> x * x end) == [1, 4, 9]
  end

	test "reduce" do
		numbers = [1, 2, 3]
		assert MapReduceFilter.naive_reduce(numbers, 0, &+/2) == 6
	end

	test "filter" do
		numbers = [1, 2, 3]
		assert MapReduceFilter.naive_filter(numbers, &Integer.is_odd/1) == [1, 3]
	end
end
