defmodule Recursion do

	def stack_overflow_sum(0), do: 0
	def stack_overflow_sum(num), do: num + stack_overflow_sum(num - 1)

	# convenience function to front-end tail_recursive_sum/2
	def tail_recursive_sum(num), do: tail_recursive_sum(num,0)

	def tail_recursive_sum(0, acc), do: acc
	def tail_recursive_sum(num, acc), do: tail_recursive_sum(num - 1, acc + num)

	# bad, because the recursive function ends in two function calls (no tco)
	def fibonacci_bad(0), do: 0
	def fibonacci_bad(1), do: 1
	def fibonacci_bad(n), do: fibonacci_bad(n-1) + fibonacci_bad(n-2)

	# much better
	def fibonacci_good(n), do: fibonacci_good(1,0,n-1)
	def fibonacci_good(a,_b,0), do: a
	def fibonacci_good(a,b,n), do: fibonacci_good(a+b,a,n-1)

	# building a list of the fibonacci sequence
	# but it calls fibonnaci_good way too often
	# not the pattern matching in fibonacci_list/3 where we assert that
	#  param1 and param2 are equal by binding them to the same variable
	def fibonacci_list(n), do: fibonacci_list(1,n,[])
	def fibonacci_list(n,n,l), do: lists_reverse([fibonacci_good(n)|l])
	def fibonacci_list(a,n,l), do: fibonacci_list(a+1,n,[fibonacci_good(a)|l])

	# building lists the right way means you often have to reverse
	# you should always build by adding to the head (prepending)
	# you should always interate (recursively) by removing the head
	def lists_reverse(l), do: lists_reverse(l,[])
	def lists_reverse([],l), do: l
	def lists_reverse([h|t],l), do: lists_reverse(t,[h|l])

	# this fibonacci sequence uses good tail recursion and optimal calculation
	# of the elements in the list. it is better.
	def fibonacci_list_better(n), do: fibonacci_list_better(1,0,n,[])
	def fibonacci_list_better(_a,n,n,l), do: lists_reverse(l)
	def fibonacci_list_better(a,b,n,l), do: fibonacci_list_better(a+b,a,n,[a|l])
end
