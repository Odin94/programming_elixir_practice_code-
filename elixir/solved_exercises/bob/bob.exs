defmodule Bob do
  def hey(input) do
    cond do
      is_empty(input) ->
        "Fine. Be that way!"

      contains_letters(input) and is_question(input) and is_shouted(input) ->
        "Calm down, I know what I'm doing!"

      is_question(input) ->
        "Sure."

      contains_letters(input) and is_shouted(input) ->
        "Whoa, chill out!"

      true ->
        "Whatever."
    end
  end

  defp is_empty(input) do
    String.replace(input, " ", "") == ""
  end

  defp contains_letters(input) do
    Regex.match?(~r/\p{L}/, input)
  end

  defp is_question(input) do
    String.ends_with?(input, "?")
  end

  defp is_shouted(input) do
    String.upcase(input) == input
  end
end
