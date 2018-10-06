defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """
  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    charlist_sentence = String.to_charlist(sentence)

    lowercase_alpha_list()
    |> Enum.zip(uppercase_alpha_list())
    |> Enum.all?(fn {lower, upper} ->
      Enum.member?(charlist_sentence, lower) or Enum.member?(charlist_sentence, upper)
    end)
  end

  defp lowercase_alpha_list() do
    ?a..?z
    |> Enum.to_list()
  end

  defp uppercase_alpha_list() do
    ?A..?Z
    |> Enum.to_list()
  end
end
