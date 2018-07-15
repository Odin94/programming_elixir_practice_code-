defmodule PigLatin do
  @vowels ["a", "i", "u", "e", "o", "A", "I", "U", "E", "O", "yt", "xr", "YT", "XR"]
  @special_consonants ["qu", "squ", "QU", "SQU"]
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    String.split(phrase)
    |> Enum.map(fn word -> translate_word(word) end)
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    word
    |> String.graphemes()
    |> get_leading_consonants([])
    |> build_translated_word
  end

  @spec get_leading_consonants([String.t()], [String.t()]) :: {String.t(), String.t()}
  defp get_leading_consonants([first, second, third | tail], leading_consonants) do
    cond do
      # check consontants that are treated as vowels
      "#{first}#{second}" in @vowels ->
        {Enum.join(leading_consonants), Enum.join([third | tail])}

      # check vowels that are treated as consonants
      "#{first}#{second}#{third}" in @special_consonants ->
        get_leading_consonants(tail, leading_consonants ++ [first, second, third])

      "#{first}#{second}" in @special_consonants ->
        get_leading_consonants([third | tail], leading_consonants ++ [first, second])

      first in @vowels ->
        {Enum.join(leading_consonants), Enum.join([first, second, third | tail])}

      # first is regular consonant
      true ->
        get_leading_consonants([second, third | tail], leading_consonants ++ [first])
    end
  end

  defp get_leading_consonants([first, second], leading_consonants) do
    cond do
      # check consontants that are treated as vowels
      "#{first}#{second}" in @vowels ->
        {Enum.join(leading_consonants), "#{first}#{second}"}

      "#{first}#{second}" in @special_consonants ->
        {Enum.join(leading_consonants) <> "#{first}#{second}", ""}

      first in @vowels ->
        {Enum.join(leading_consonants), first <> second}

      # first is regular consonant
      true ->
        get_leading_consonants([second], leading_consonants ++ [first])
    end
  end

  defp get_leading_consonants([first], leading_consonants) do
    if first in @vowels,
      do: {Enum.join(leading_consonants), first},
      else: {Enum.join(leading_consonants) <> first, ""}
  end

  defp get_leading_consonants([], leading_consonants), do: {Enum.join(leading_consonants), ""}

  defp build_translated_word({leading_consonants, rest_of_word}) do
    rest_of_word <> leading_consonants <> "ay"
  end
end
