# Referential Transparency

> An expression is said to be referentially transparent if it can be replaced with its value without changing the behavior of a program (in other words, yielding a program that has the same effects and output on the same input).  - Wikipedia

Same inputs == same outputs

```python
def ref_trans(x, y):
    return x + y
```

```python
y = 1

def ref_opaq(x):
    # relies on a global, which can be changed by other functions
    global y
    y += 1
    return x + y
```

`ref_trans(1, 2)` can be thought of as `3` always.
`ref_opaq(1)` changes based on events external to `ref_opaq` and cannot be thought of as `3` always.

```python
>>> ref_opaq(1)
3
>>> ref_opaq(1)
4
>>> ref_opaq(1)
5
```

Referential transparency isn't just about global state.
Any function that would return a different value because of any state is referentially opaque.
Instance methods that change their instance's attributes are referentially opaque.

```python
def elapsed_time(x, y):
    return (y - x).total_seconds
```

```python
from datetime import datetime

def elapsed_time(x):
    # elapsed_time(datetime(year=2016, month=1, day=1)) will return different values based on when it is called
    y = datetime.now()
    return (y - x).total_seconds
```

Side effects can also make a function opaque.
Often, changing the the inputs in-place will make the function opaque.

Elixir encourages referential transparency with immutability and single assignment.
Not everything can be transparent, eg displaying, IO, etc.
Encourages you to isolate transparent and opaque functions.

```elixir
iex(1)> add_one = &(&1 + 1)
#Function<6.50752066/1 in :erl_eval.expr/5>
iex(2)> x = 1
1
iex(3)> add_one.(x)
2
iex(4)> x
1
```

`add_one` does not mutate `x`.
There are no side effects.
`add_one.(1)` will always return 2.

Macros are hygenic in Elixir due to late resolution. Read about [macro hygiene](http://elixir-lang.org/getting-started/meta/macros.html#macros-hygiene).

## But why referential transparency?

1.  Easier to test
1.  Easier to reason about
1.  Easier to use concurrently
