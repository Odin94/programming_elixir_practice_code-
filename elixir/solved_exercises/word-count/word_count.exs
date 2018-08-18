defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> remove_punctuation
    |> remove_consecutive_whitespace
    |> String.split(" ", trim: true)
    |> Enum.reduce(%{}, &count_reduce/2)
  end

  defp remove_punctuation(word), do: String.replace(word, ~r/[\.\,\?\!\&\^\"\@\$\%\:\_]/, " ")

  defp remove_consecutive_whitespace(word), do: String.replace(word, ~r/\s+/, " ")

  defp count_reduce(word, map) do
    Map.update(map, String.downcase(word), 1, &(&1 + 1))
  end
end
