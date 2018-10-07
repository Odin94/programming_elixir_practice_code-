defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new() do
    %Queens{black: {7, 3}, white: {0, 3}}
  end

  def new(white, black) when white == black, do: raise(ArgumentError)

  def new(white, black) do
    %Queens{black: black, white: white}
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    0..7
    |> Enum.map(&string_row(queens, &1))
    |> Enum.join("\n")
  end

  defp string_row(%Queens{black: black, white: white}, row) do
    0..7
    |> Enum.map(fn col ->
      case {row, col} do
        ^white -> "W"
        ^black -> "B"
        _ -> "_"
      end
    end)
    |> Enum.join(" ")
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%{black: {same_row, _}, white: {same_row, _}}), do: true
  def can_attack?(%{black: {_, same_col}, white: {_, same_col}}), do: true

  def can_attack?(queens), do: diagonal?(queens)

  defp diagonal?(%{black: {b_row, b_col}, white: {w_row, w_col}}) do
    abs(b_row - w_row) == abs(b_col - w_col)
  end
end
