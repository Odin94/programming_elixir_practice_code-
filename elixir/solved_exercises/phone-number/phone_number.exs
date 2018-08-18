defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t()) :: String.t()
  def number(raw) do
    actual_number =
      raw
      |> clean
      |> remove_leading_one

    cond do
      valid_number?(actual_number) -> actual_number
      true -> "0000000000"
    end
  end

  defp clean(number) do
    Regex.replace(~r/\(|\)| |\-|\.|\+/, number, "")
  end

  defp remove_leading_one(clean_number) do
    if String.starts_with?(clean_number, "1") and String.length(clean_number) == 11 do
      String.slice(clean_number, 1..11)
    else
      clean_number
    end
  end

  defp valid_number?(clean_number) do
    not Regex.match?(~r/\p{L}/, clean_number) and String.length(clean_number) == 10 and
      not String.starts_with?(String.slice(clean_number, 0..2), ["0", "1"]) and
      not String.starts_with?(exchange_code(clean_number), ["0", "1"])
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    raw |> number |> String.slice(0..2)
  end

  def exchange_code(clean_number) do
    String.slice(clean_number, 3..5)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    clean_number = number(raw)

    "(#{area_code(clean_number)}) #{exchange_code(clean_number)}-#{
      String.slice(clean_number, 6..10)
    }"
  end
end
