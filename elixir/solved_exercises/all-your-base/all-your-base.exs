defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert(digits, base_a, base_b) when digits == [] or base_a < 2 or base_b < 2, do: nil

  def convert(digits, base_a, base_b) do
    if Enum.any?(digits, &(&1 >= base_a or &1 < 0)) do
      nil
    else
      digits
      |> Enum.drop_while(&(&1 == 0))
      |> do_convert(base_a, base_b)
    end
  end

  defp do_convert(digits, base_a, 10) do
    digits
    |> convert_to_decimal_number(base_a)
    |> List.first()
    |> Integer.digits()
  end

  defp do_convert(digits, base_a, base_b) do
    digits
    |> convert_to_decimal_number(base_a)
    |> List.first()
    |> convert_from_decimal(base_b)
    |> Enum.reverse()
  end

  defp convert_from_decimal(number, target_base) when rem(number, target_base) == number,
    do: [rem(number, target_base)]

  # note: Integer.digits(number, base) could be used to make this easier
  defp convert_from_decimal(number, target_base) do
    [
      rem(number, target_base)
      | convert_from_decimal(Kernel.div(number, target_base), target_base)
    ]
  end

  # note: Integer.undigits(number, base) could be used to make this easier
  defp convert_to_decimal_number(digits, source_base) do
    digits
    |> Enum.reverse()
    |> Enum.zip(0..length(digits))
    |> Enum.reduce(0, fn {n, index}, acc -> acc + n * :math.pow(source_base, index) end)
    |> Kernel.trunc()
    |> List.wrap()
  end
end
