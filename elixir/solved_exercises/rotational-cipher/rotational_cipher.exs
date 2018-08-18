defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) when rem(shift, 26) == 0 do
    text
  end

  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.map(fn c -> rotate_character(c, shift) end)
    |> to_string
  end

  defp rotate_character(c, shift) when c in ?a..?z, do: wrap_character(c, shift, ?a, 26)

  defp rotate_character(c, shift) when c in ?A..?Z, do: wrap_character(c, shift, ?A, 26)

  defp rotate_character(c, _shift), do: c

  defp wrap_character(c, shift, min, max_shift), do: min + rem(c - min + shift, max_shift)
end
