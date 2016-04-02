defmodule MapReduceFilter do
	
	def naive_map(collection, lambda), do: naive_map(collection, lambda, [])

	def naive_map([], _lambda, result), do: result
	def naive_map([current|rest], lambda, result) do
		naive_map(rest, lambda, result ++ [lambda.(current)])
	end

	def naive_reduce([], accumulator, lambda), do: accumulator
	def naive_reduce([current|rest], accumulator, lambda) do
		naive_reduce(rest, lambda.(accumulator, current), lambda)
	end

	def naive_filter(collection, lambda), do: naive_filter(collection, [], lambda)
	
	def naive_filter([], result, lambda), do: result
	def naive_filter([current|rest], accumulator, lambda) do
		if lambda.(current) do
			naive_filter(rest, accumulator ++ [current], lambda)
		else
			naive_filter(rest, accumulator, lambda)
		end
	end
end
