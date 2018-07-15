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
  @month_map %{
    january: 1,
    february: 2,
    march: 3,
    april: 4,
    march: 5,
    june: 6,
    july: 7,
    august: 8,
    september: 9,
    october: 10,
    november: 11,
    december: 12
  }

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
  end

  def meetup(year, month, weekday, :second) do
  end

  def meetup(year, month, weekday, :third) do
  end

  def meetup(year, month, weekday, :fourth) do
  end

  def meetup(year, month, weekday, :last) do
  end

  def days_in_month(year, month) do
    month_num = @month_map[month]
    Date.days_in_month(Date.new(year, month_num, 1))
  end

  # call this, then get x-th item of returned list, which is the day-date we need
  def matching_days(year, month, weekday) do
    max_day = days_in_month(year, month)

    Enum.reduce(1..max_day, [], fn day, acc ->
      cond do
        @day_map.get(Date.day_of_week(Date.new(year, month, day))) == weekday -> acc ++ day
        true -> acc
      end
    end)
  end
end
