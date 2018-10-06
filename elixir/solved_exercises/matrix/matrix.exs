defmodule Matrix do
  defstruct matrix: nil

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce([], fn row_str, acc ->
      new_row =
        row_str
        |> String.split(" ", trim: true)
        |> Enum.map(fn c -> String.to_integer(c) end)

      acc ++ [new_row]
    end)
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(matrix) do
    matrix
    |> Enum.map(fn row ->
      row
      |> Enum.join(" ")
      |> String.trim()
    end)
    |> Enum.join("\n")
    |> String.trim()
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(matrix) do
    matrix
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(matrix, index) do
    Enum.at(matrix, index)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns([head | _tail] = matrix) do
    length = Enum.count(head)

    0..(length - 1)
    |> Enum.map(fn i -> column(matrix, i) end)
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index) do
    matrix
    |> Enum.map(fn row ->
      Enum.at(row, index)
    end)
  end
end
