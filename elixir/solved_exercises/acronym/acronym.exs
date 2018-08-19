defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.graphemes()
    |> Enum.reduce({[], :no_cap}, fn g, {acc, cap} ->
      cond do
        String.match?(g, ~r/^[[:alpha:]]+$/u) and (g == String.upcase(g) or cap == :cap) ->
          {[String.upcase(g) | acc], :no_cap}

        not String.match?(g, ~r/^[[:alpha:]]+$/u) ->
          {acc, :cap}

        true ->
          {acc, :no_cap}
      end
    end)
    |> elem(0)
    |> Enum.reverse()
    |> Enum.join()
  end
end
