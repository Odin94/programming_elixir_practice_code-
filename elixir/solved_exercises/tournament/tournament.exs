defmodule Tournament do
  @single_win_default %{"played" => 1, "won" => 1, "tied" => 0, "lost" => 0, "points" => 3}
  @single_draw_default %{"played" => 1, "won" => 0, "tied" => 1, "lost" => 0, "points" => 1}
  @single_loss_default %{"played" => 1, "won" => 0, "tied" => 0, "lost" => 1, "points" => 0}

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    result =
      input
      |> to_stats_map
      |> to_sorted_list
      |> to_pretty_string

    result
  end

  defp to_stats_map(input) do
    input
    |> Enum.map(&String.split(&1, ";"))
    |> Enum.reduce(%{}, fn game, stats_map ->
      case game do
        [team1, team2, "win"] ->
          stats_map
          |> Map.update(team1, @single_win_default, &add_win(&1))
          |> Map.update(team2, @single_loss_default, &add_loss(&1))

        [team1, team2, "loss"] ->
          stats_map
          |> Map.update(team1, @single_loss_default, &add_loss(&1))
          |> Map.update(team2, @single_win_default, &add_win(&1))

        [team1, team2, "draw"] ->
          stats_map
          |> Map.update(team1, @single_draw_default, &add_draw(&1))
          |> Map.update(team2, @single_draw_default, &add_draw(&1))
        _ ->
        stats_map
      end
    end)
  end

  @doc """
  Takes a teams stats map and adds a win by updating the "played" (+1), "won" (+1),
  and "points" (+3) entries
  """
  defp add_win(stats) do
    stats
    |> Map.update!("played", &(&1 + 1))
    |> Map.update!("won", &(&1 + 1))
    |> Map.update!("points", &(&1 + 3))
  end

  defp add_draw(stats) do
    stats
    |> Map.update!("played", &(&1 + 1))
    |> Map.update!("tied", &(&1 + 1))
    |> Map.update!("points", &(&1 + 1))
  end

  defp add_loss(stats) do
    stats
    |> Map.update!("played", &(&1 + 1))
    |> Map.update!("lost", &(&1 + 1))
  end

  @doc """
  Takes a mapping of team names to their stats and turns it into a list
  of %{team name, stats} structs sorted by score or alphabetically if tied
  """
  defp to_sorted_list(stats_map) do
    stats_map
    |> Enum.map(fn {team, stats} ->
      Map.put(stats, "name", team)
    end)
    |> Enum.sort(fn l, r ->
      if l["points"] != r["points"] do
        l["points"] >= r["points"]
      else
        r["name"] >= l["name"]
      end
    end)
  end

  # score list is a list of maps that look like this:
  # %{
  #     "lost" => 1,
  #     "name" => "team3",
  #     "played" => 1,
  #     "points" => 0,
  #     "tied" => 0,
  #     "won" => 0
  #   }
  defp to_pretty_string(stats_list) do
    table =
      stats_list
      |> Enum.reduce("", fn stats, acc ->
        "#{acc}\n#{get_name_string(stats)}#{get_score_string(stats)}"
      end)
      |> String.trim("\n")

    """
    Team                           | MP |  W |  D |  L |  P
    #{table}
    """
    |> String.trim("\n")
  end

  defp get_name_string(stats), do: String.pad_trailing(stats["name"], 31)

  defp get_score_string(stats) do
    "|  #{stats["played"]} |  #{stats["won"]} |  #{stats["tied"]} |  #{stats["lost"]} |  #{
      stats["points"]
    }"
  end
end
