# FirstClassFun

## Functions as *First Class Objects* in Elixir

Functions as *First Class Objects* **means**:

1. a function can be assigned to a variable; this is different than taking the result of a function call and assigning it to a variable
2. a function can be passed as an argument to another function
3. a function can be returned as the result of another function

Anonymous functions are defined *inline* and not given a name. These use the keyword `fn` where the function name would normally be found. Anonymous functions are quite common when in situations were functions are used as first class objects.

Functions bound to variables (and parameters) as invoked using a dot-parens syntax

```elixir
f = fn(x) x + 1 end
6 = f.(5)
```

There is a different syntax used when you want to treat a *named* function as a first class object. In this case, you use the ampersand (`&`) *reminiscent of a C function pointer* along with an **arity** designation. A similar example to the one above using a local function

```elixir
defmodule Foo do
  def decrement(x) do
    x - 1
  end  
end
f = &Foo.decrement/1
4 = f.(5)
```

I read this as "give me a pointer to a function in module `Foo` named `decrement` which takes `1` argument." It's a little more involved than uasing anonymous functions, but hopefully you can see why you might need the ability to access named functions in this way.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add first_class_fun to your list of dependencies in `mix.exs`:

        def deps do
          [{:first_class_fun, "~> 0.0.1"}]
        end

  2. Ensure first_class_fun is started before your application:

        def application do
          [applications: [:first_class_fun]]
        end
