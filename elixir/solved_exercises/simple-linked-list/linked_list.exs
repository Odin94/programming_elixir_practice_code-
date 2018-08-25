defmodule LinkedList do
  @opaque t :: tuple()
  import Kernel, except: [length: 1]

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    {nil, nil}
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push({nil, nil}, elem), do: {elem, nil}
  def push(list, elem), do: {elem, list}

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(nil), do: 0
  def length({nil, nil}), do: 0
  def length({_, nil}), do: 1
  def length({_, next}), do: 1 + length(next)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?({nil, nil}), do: true
  def empty?(_list), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(nil), do: {:error, :empty_list}
  def peek({nil, nil}), do: {:error, :empty_list}
  def peek({val, _}), do: {:ok, val}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(nil), do: {:error, :empty_list}
  def tail({nil, nil}), do: {:error, :empty_list}
  def tail({_, next}), do: {:ok, next}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(nil), do: {:error, :empty_list}
  def pop({nil, nil}), do: {:error, :empty_list}
  def pop({val, next}), do: {:ok, val, next}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list([]), do: new()
  def from_list(list), do: list |> Enum.reverse() |> Enum.reduce(new(), &push(&2, &1))

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list({nil, nil}), do: []
  def to_list(list), do: to_list(list, [])
  defp to_list({val, nil}, acc), do: [val | acc] |> Enum.reverse()
  defp to_list({val, next}, acc), do: to_list(next, [val | acc])

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(empty_list = {nil, nil}), do: empty_list
  def reverse(list), do: reverse(nil, list)
  defp reverse(previous, {val, nil}), do: {val, previous}
  defp reverse(previous, {val, next}), do: reverse({val, previous}, next)
end
