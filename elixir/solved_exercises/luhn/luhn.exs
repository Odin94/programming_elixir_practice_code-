# NOTE: I'm pretty sure Test

# test "a simple valid SIN that becomes invalid if reversed" do
#   assert Luhn.valid?("59")
# end

# is broken. "59" is not a valid SIN according to the rules described in the README

defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    number = String.replace(number, " ", "")

    with true <- at_least_two_characters?(number),
         true <- contains_only_legal_chars?(number) do
      valid_number?(number)
    end
  end

  defp at_least_two_characters?(number), do: String.length(number) > 1

  defp contains_only_legal_chars?(number), do: String.match?(number, ~r/^[0-9]*$/)

  defp valid_number?(number) do
    IO.inspect(number)

    number
    |> String.graphemes()
    |> double_every_second([])
    |> IO.inspect()
    |> subtract_from_greater_than_nine()
    |> IO.inspect()
    |> Enum.sum()
    |> evenly_divisible_by?(10)
  end

  defp double_every_second([head, second | tail], acc) do
    double_every_second(tail, [String.to_integer(second) * 2, String.to_integer(head) | acc])
  end

  defp double_every_second([head | []], acc), do: Enum.reverse([String.to_integer(head) | acc])
  defp double_every_second([], acc), do: Enum.reverse(acc)

  defp subtract_from_greater_than_nine(number) do
    Enum.map(number, fn n ->
      if n > 9, do: n - 9, else: n
    end)
  end

  defp evenly_divisible_by?(number, divisor), do: rem(number, divisor) == 0
end
