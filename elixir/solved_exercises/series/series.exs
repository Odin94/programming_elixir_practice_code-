defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) when size < 1 or size > length(s) or s == "", do: []

  def slices(s, size) do
    do_slices(String.graphemes(s), size)
  end

  defp do_slices([], _size), do: []
  defp do_slices(s, size) when length(s) < size, do: []

  defp do_slices([_head | tail] = s, size) do
    [Enum.take(s, size) |> Enum.join() | do_slices(tail, size)]
  end
end
