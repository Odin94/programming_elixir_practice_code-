defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(list), do: count(list, 0)
  defp count([], acc), do: acc
  defp count([_head | tail], acc), do: count(tail, acc + 1)

  @spec reverse(list) :: list
  def reverse(l), do: reverse(l, [])
  defp reverse([], acc), do: acc
  defp reverse([head | tail], acc), do: reverse(tail, [head | acc])

  @spec map(list, (any -> any)) :: list
  def map([], _f), do: []
  def map([head | tail], f), do: [f.(head) | map(tail, f)]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(list, f), do: filter(list, f, [])

  defp filter([], _f, acc), do: Enum.reverse(acc)

  defp filter([head | tail], f, acc) do
    case f.(head) do
      true -> filter(tail, f, [head | acc])
      false -> filter(tail, f, acc)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f), do: acc
  def reduce([head | tail], acc, f), do: reduce(tail, f.(head, acc), f)

  @spec append(list, list) :: list
  def append([], []), do: []
  def append([head | tail], b), do: [head | append(tail, b)]
  def append([], [head | tail]), do: [head | append([], tail)]

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([[] | outer_tail]), do: concat(outer_tail)
  def concat([[head | tail] | outer_tail]), do: [head | concat([tail | outer_tail])]
  def concat([head | tail]), do: [head | concat(tail)]
end
