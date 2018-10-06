defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) when number > 0 and number <= 64 do
    square(number, 1)
  end

  def square(number), do: {:error, "The requested square must be between 1 and 64 (inclusive)"}

  def square(1, acc), do: {:ok, acc}

  def square(number, acc), do: square(number - 1, acc * 2)

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total() do
    sum =
      2..64
      |> Enum.reduce([1], fn _n, acc = [last | _tail] -> [last * 2 | acc] end)
      |> Enum.sum()

    {:ok, sum}
  end
end
