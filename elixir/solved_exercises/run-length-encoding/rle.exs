defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""

  def encode(string) do
    string
    |> String.graphemes()
    |> (&Enum.reduce(&1, [{List.first(&1), 0}], fn g, acc ->
          [{letter, count} | tail] = acc

          cond do
            g == letter -> [{letter, count + 1} | tail]
            true -> [{g, 1} | acc]
          end
        end)).()
    |> Enum.reverse()
    |> Enum.map(fn
      {letter, 1} -> letter
      {letter, count} -> "#{count}#{letter}"
    end)
    |> Enum.join()
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    string
    |> String.graphemes()
    |> Enum.chunk_by(&String.match?(&1, ~r/[A-Za-z ]/))
    |> decode_chunks()
  end

  defp decode_chunks(chunks) do
    chunks
    |> List.flatten()
    |> decode_list()
    |> Enum.join()
  end

  defp decode_list([]), do: []
  defp decode_list([letter]), do: [letter]

  defp decode_list(list) do
    {count_as_number, [letter | tail]} = get_numbers_and_tail(list)
    [String.duplicate(letter, count_as_number) | decode_list(tail)]
  end

  defp get_numbers_and_tail([head | tail] = list, digits \\ []) do
    if String.match?(head, ~r/[0-9]/) do
      get_numbers_and_tail(tail, digits ++ [head])
    else
      case digits do
        [] -> {1, list}
        number -> {digits |> Enum.join() |> String.to_integer(), list}
      end
    end
  end
end
