defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Enum.map(fn {k, v} ->
      v
      |> Enum.map(fn str -> {str |> String.downcase(), k} end)
    end)
    |> List.flatten()
    |> Enum.into(%{})
  end
end
