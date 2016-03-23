defmodule PatternMatching do
  @moduledoc

  defmodule Language do
    @moduledoc
    defstruct [:language_name, :special_code]
  end

  defmodule User do
    @moduledoc

    defstruct user_name: nil, language: %Language{}

    def greet(%User{user_name: name, language: %{language_name: "Elixir"}}) do
      "Hi #{name}! Let's high-five and write some Elixir!"
    end

    def greet(%User{user_name: "Bob"} = bob) do
      "Hey, Bob's back and he learned #{bob.language.language_name}!"
    end

    def greet(user) do
      "Well hello! Let's learn you some Elixir"
    end
    
  end

end
