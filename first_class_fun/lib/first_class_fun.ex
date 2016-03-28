defmodule FirstClassFun do

  # run `mix test` to see all the magic
  
  # functions as first class objects means
  # 1. functions can be assigned to variables; this is different than
  #    the results of a function call being assigned to a variables
  # 2. functions can be passed as arguments to a function
  # 3. functions can be returned by a function

  # functions bound to variables (and parameters) as invoked
  #   using a dot-parens syntax
  #   f = fn(x) x + 1 end
  #   f.(5) == 6

  # lists_any accepts a function as an argument, it returns true if
  #   any element in the list causes that function to return true

  # shamelessly lifted from Erlang's lists:any/2

  def lists_any([],_pred?), do: :false
  def lists_any([h|_t]=list,pred?), do: lists_any(list,pred?,pred?.(h))
  def lists_any(_l,_pred?,:true), do: :true
  def lists_any([_h|t],pred?,_false), do: lists_any(t,pred?)

  # equality_predicate generates a predicate function that can be used
  #   as an argument to lists_any

  # generates a predicate function that can be dropped into lists_any
  def equality_predicate(n), do: fn(e) -> e == n end

  # lists_filter is slightly more complicated that lists_any
  # it uses the predicate to create a new lists of all the elements from
  #   the first list that make the function return true

  # similarly lifted from lists:filter/2
  def lists_filter(list,predicate?), do: lists_filter(list,predicate?,[])
  def lists_filter([],_predicate?,filtered_list), do: lists_reverse(filtered_list)
  def lists_filter([h|_t]=list,predicate?,filtered_list) do
    lists_filter(list,predicate?,filtered_list,predicate?.(h))
  end
  def lists_filter([h|t],predicate?,filtered_list,:true) do
    lists_filter(t,predicate?,[h|filtered_list])
  end
  def lists_filter([_h|t],predicate?,filtered_list,:false) do
    lists_filter(t,predicate?,filtered_list)
  end

  # and lists:reverse/1
  # def lists_reverse(list), do: lists_reverse(list,[])
  # def lists_reverse([],reversed_list), do: reversed_list
  # def lists_reverse([h|t],reversed_list), do: lists_reverse(t,[h|reversed_list])

  # we can write our own trivial implementation of lists_reverse, but here's
  #   how to call the builtin from Erlang's lists module lists:reverse/1
  def lists_reverse(list), do: :lists.reverse(list)

end
