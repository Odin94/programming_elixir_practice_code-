defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(&row_str_to_int_row/1)
  end

  defp row_str_to_int_row(row_str) do
    row_str
    |> String.split(" ")
    |> Enum.map(&String.to_integer(&1))
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    split_str = String.split(str, "\n")
    length = Enum.count(split_str |> Enum.at(0) |> String.split(" "))

    0..(length - 1)
    |> Enum.map(fn pos -> get_col_at(split_str, pos) end)
  end

  defp get_col_at(row_strings, pos) do
    row_strings
    |> Enum.map(fn row_str ->
      row_str
      |> String.split(" ")
      |> Enum.at(pos)
      |> String.to_integer()
    end)
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix (>= all in row, <= all in col)
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    rows =
      rows(str)
      |> get_largest_in_rows()

    # TODO:  need to get row numbers for cols and col numbers for rows - pass index from outer list
    columns(str)
    |> get_smallest_in_cols()
    |> IO.inspect()
    |> Enum.reduce([], fn {_col_elem_number, col_elem_index}, acc ->
      case Enum.find(rows, nil, fn {_row_elem_number, row_elem_index} ->
             row_elem_index == col_elem_index
           end) do
        {_num, row_index} -> [{col_elem_index, row_index} | acc]
        nil -> acc
      end
    end)
  end

  defp get_largest_in_rows(rows) do
    rows
    |> Enum.map(fn row ->
      row
      |> Enum.with_index()
      |> Enum.sort(&(elem(&1, 0) >= elem(&2, 0)))
      |> take_while_same()
    end)
    |> List.flatten()
  end

  defp get_smallest_in_cols(cols) do
    cols
    |> Enum.map(fn col ->
      col
      |> Enum.with_index()
      |> Enum.sort(&(elem(&1, 0) <= elem(&2, 0)))
      |> take_while_same()
    end)
    |> List.flatten()
  end

  defp take_while_same([]), do: []

  defp take_while_same([head | tail]) do
    [head | tail |> Enum.take_while(fn c -> elem(c, 0) == elem(head, 0) end)]
  end
end
