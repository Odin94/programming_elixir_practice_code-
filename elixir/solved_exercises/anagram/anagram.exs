defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.filter(fn cand ->
      anagram?(base, cand) and String.downcase(base) != String.downcase(cand)
    end)
  end

  defp anagram?(str1, str2), do: sort_and_downcase(str1) == sort_and_downcase(str2)

  defp sort_and_downcase(str) do
    str
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort()
  end
end
