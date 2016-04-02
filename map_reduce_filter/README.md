# Map Reduce Filter
Map, reduce, and filter are common patterns used in functional languages. Elixir provides implementations of the patterns as a convenience for developers. These implementations live in the [Enum](http://elixir-lang.org/docs/v1.2/elixir/Enum.html) and [Stream](http://elixir-lang.org/docs/stable/elixir/Stream.html) modules. They recursively process data according to the [Enumerable protocol](http://elixir-lang.org/docs/v1.2/elixir/Enumerable.html). Because of this, any user created data structures can be processed through these modules in the same way that built-in types.

## Map
The map pattern recursively processes an Enumerable data structure and applies a function to it.

```elixir
iex(1)> numbers = [1, 2, 3]
[1, 2, 3]
iex(2)> Enum.map(numbers, fn(x) -> x * x end)
[1, 4, 9]
```

The above code passes the list of numbers and a lambda into the `map` function. The lambda squares the number that is passed in. `map` iterates over the list and collects the result of calling the function on each implementation.

```elixir
def naive_map(collection, lambda), do: naive_map(collection, lambda, [])

def naive_map([], _lambda, result), do: result
def naive_map([current|rest], lambda, result) do
    naive_map(rest, lambda, result ++ [lambda.(current)])
end

```

## Reduce
The reduce pattern recursively processes an Enumerable data structure and applies a function to it. The output is a single value, in contrast with `map`

```elixir
iex(1)> numbers = [1, 2, 3]
[1, 2, 3]
iex(2)> Enum.reduce(numbers, 0, &+/2)
6
```

The above code passes the list of numbers, an initial accumulator value, and a reference to the sum function into the `reduce` function. The sum function adds the accumulation value and the current number for each number of the list.

```elixir
def naive_reduce([], accumulator, lambda), do: accumulator
def naive_reduce([current|rest], accumulator, lambda) do
    naive_reduce(rest, lambda.(accumulator, current), lambda)
end
```

## Filter
The filter pattern recursively processes an Enumerable data structure and applies a function to it in order to remove elements from the collection.

```elixir
iex(1)> numbers = [1, 2, 3]
[1, 2, 3]
iex(2)> require Integer
nil
iex(3)> Enum.filter(numbers, &Integer.is_odd/1)
[1, 3]
```

The above code passes the list of numbers and a reference to `Integer.is_odd` into the function. The filter function removes any element that does not result in a true value when passed into the supplied function. Side note: `require Integer` is used because `is_odd/1` is a compiler macro ([ref](http://elixir-lang.org/getting-started/alias-require-and-import.html#require)).

```elixir
def naive_filter(collection, lambda), do: naive_filter(collection, [], lambda)

def naive_filter([], result, lambda), do: result
def naive_filter([current|rest], accumulator, lambda) do
    if lambda.(current) do
        naive_filter(rest, accumulator ++ [current], lambda)
    else
        naive_filter(rest, accumulator, lambda)
    end
end
```

## Lazy v. Eager
So far, all the examples have referenced the `Enum` module. The `Stream` module provides the same functionality, but is lazily evaluated. This becomes important when chaining together calls. Eagerly evaluated logic processes as much as possible. Lazily evaluated logic processes only what is neaded at the time. This can be seen in the following iex session.

```elixir
iex(1)> numbers = [1,2,3]
[1, 2, 3]
iex(2)> require Integer
nil
iex(3)> Enum.filter(numbers, &Integer.is_odd/1)
[1, 3]
iex(4)> Stream.filter(numbers, &Integer.is_odd/1)
#Stream<[enum: [1, 2, 3], funs: [#Function<6.109616649/1 in Stream.filter/2>]]>
iex(5)> Enum.filter(numbers, &Integer.is_odd/1) |> Enum.reduce(0, &+/2)
4
iex(6)> Stream.filter(numbers, &Integer.is_odd/1) |> Enum.reduce(0, &+/2)
4
```

The return value of `Enum.filter` is [1,3]. The return value of `Stream.filter` is a stream that can be used to retrieve values on demand. The stream is passed in to `Enum.reduce`. Since Enum can handle any source that is `Enumerable`, the stream is processed at this point in its entiretly. This behavior is useful in cases where the collection is potentially large, because it will avoid intermediary collections stored in memory.

## Usages
By applying these patterns and the others found in the `Enum` and `Stream` modules, programmers can quickly interact with data in ways that are well defined and well understood in the context of functional programming.