defmodule PatternMatchingTest do
  use ExUnit.Case
  doctest PatternMatching
  alias PatternMatching.{User, Role}

  test "A few simple cases of matching" do
    foo = 42
    42 = foo
    # TODO uncomment for the lolz!
    # 43 = foo

    [the_head | the_tail] = [1, 2, 3]
    assert the_head == 1
    assert the_tail == [2, 3]

    {foo, bar} = {"tuple", {"more things", "in another tuple"}}
    assert foo = "tuple"
    assert bar = {"more things", "in another tuple"}

    santas_list = [nice: "dave", naughty: "not dave", nice: "matt", naughty: "not matt"]
    filtered_list = for {:nice, name} <- santas_list, do: name

    assert filtered_list == ["dave", "matt"]
    
  end

  test "A more interesting example" do
    new_programmer = %User{}
    assert User.greet(new_programmer) ==
    "Well hello! Let's learn you some Elixir"

    alchemist = %User{user_name: "Dave", language: %{language_name: "Elixir"}}
    assert User.greet(alchemist) ==
    "Hi Dave! Let's high-five and write some Elixir!"

    bob = %User{user_name: "Bob", language: %{language_name: "Ruby"}}

    assert User.greet(bob) == "Hey, Bob's back and he learned Ruby!"

  end


  test "taking a look at matches in case" do
    user = %{user_name: "Dave"}
    foo = case user do
      %{user_name: "Dave"} -> "It's Dave!"
      %{user_name: _ } -> "I have no clue who it is!"
      _ -> "Are we sure this is even a user?" # TODO - checkout removing this!

    end

    assert foo == "It's Dave!"

  end



end
