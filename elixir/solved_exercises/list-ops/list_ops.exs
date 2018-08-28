defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([_head | tail]), do: 1 + count(tail)

  @spec reverse(list) :: list
  def reverse(l), do: reverse(l, [])
  def reverse([], acc), do: acc
  def reverse([head | tail], acc), do: reverse(tail, [head | acc])

  @spec map(list, (any -> any)) :: list
  def map([], _f), do: []
  def map([head | tail], f), do: [f.(head) | map(tail, f)]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _f), do: []

  def filter([head | tail], f) do
    if f.(head), do: [head | filter(tail, f)], else: filter(tail, f)
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
