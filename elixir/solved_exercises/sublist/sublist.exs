defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(same, same), do: :equal

  def compare(a, b) do
    cond do
      Enum.count(a) == Enum.count(b) ->
        :unequal

      Enum.count(a) < Enum.count(b) ->
        if is_sublist?(a, b, Enum.count(a)), do: :sublist, else: :unequal

      true ->
        if is_sublist?(b, a, Enum.count(b)), do: :superlist, else: :unequal
    end
  end

  defp is_sublist?([], _b, _a_length), do: true
  defp is_sublist?(_a, [], _a_length), do: false

  defp is_sublist?([a_head | _a_tail] = a, [b_head | b_tail] = b, a_length) do
    if a_head == b_head and Enum.take(b, a_length) === a, do: true, else: is_sublist?(a, b_tail, a_length)
  end
end
