defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @day_map %{
    1 => :monday,
    2 => :tuesday,
    3 => :wednesday,
    4 => :thursday,
    5 => :friday,
    6 => :saturday,
    7 => :sunday
  }

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, :teenth) do
    # Date.day_of_week(date) :: 1..7
  end

  def meetup(year, month, weekday, :first) do
    day = Enum.at(matching_days(year, month, weekday), 0)
    {year, month, day}
  end

  def meetup(year, month, weekday, :second) do
    day = Enum.at(matching_days(year, month, weekday), 1)
    {year, month, day}
  end

  def meetup(year, month, weekday, :third) do
    day = Enum.at(matching_days(year, month, weekday), 2)
    {year, month, day}
  end

  def meetup(year, month, weekday, :fourth) do
    day = Enum.at(matching_days(year, month, weekday), 3)
    {year, month, day}
  end

  def meetup(year, month, weekday, :last) do
    day = Enum.at(matching_days(year, month, weekday), -1)
    {year, month, day}
  end

  def days_in_month(year, month) do
    {:ok, date} = Date.new(year, month, 1)
    Date.days_in_month(date)
  end

  def matching_days(year, month, target_weekday) do
    max_day = days_in_month(year, month)

    Enum.reduce(1..max_day, [], fn day, acc ->
      {:ok, date} = Date.new(year, month, day)
      current_weekday = Date.day_of_week(date)

      cond do
        Map.get(@day_map, current_weekday) == target_weekday -> acc ++ [day]
        true -> acc
      end
    end)
  end
end
