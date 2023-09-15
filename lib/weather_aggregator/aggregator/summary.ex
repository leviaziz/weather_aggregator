defmodule WeatherAggregator.Aggregator.Summary do
  import WeatherAggregator.Aggregator.Helpers
  alias WeatherAggregator.WeatherApi.TomorrowIo
  alias WeatherAggregator.WeatherApi.VisualCrossing

  @spec fetch_summary_data(map) :: map
  def fetch_summary_data(%{}) do
    locations = ["newyork", "london"]

    res =
      Enum.map(locations, fn location ->
        one = TomorrowIo.get_location_data(location)
        two = VisualCrossing.get_location_data(location)
        %{"#{location}": aggregate(one, two)}
      end)

    [map1] = tl(res)

    hd(res)
    |> Map.merge(map1)
  end

  def fetch_summary_data(%{summary: summary}) do
    locations = Map.to_list(summary)

    res =
      Enum.map(locations, fn {location, list} ->
        one = TomorrowIo.get_location_data("#{location}")
        two = VisualCrossing.get_location_data("#{location}")

        from_sources = aggregate(one, two)
        %{"#{location}": aggregate(from_sources, list)}
      end)

    [map1] = tl(res)

    hd(res)
    |> Map.merge(map1)
  end
end
