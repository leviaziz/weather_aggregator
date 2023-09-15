defmodule WeatherAggregator.Aggregator.Detail do
  import WeatherAggregator.Aggregator.Helpers
  alias WeatherAggregator.WeatherApi.TomorrowIo
  alias WeatherAggregator.WeatherApi.VisualCrossing

  def get_each_source_separately(%{}) do
    locations = ["newyork", "london"]

    Enum.map(locations, fn location ->
      one = TomorrowIo.get_location_data(location)
      two = VisualCrossing.get_location_data(location)
      %{"#{location}": %{source_a: one, source_b: two}}
    end)
  end

  def get_each_source_separately(%{detail: details}) do
    Enum.map(details, fn detail ->
      [location] = Map.keys(detail)

      a1 = TomorrowIo.get_location_data("#{location}")
      a2 = Map.get(detail, location).source_a
      one = aggregate(a1, a2)

      b1 = VisualCrossing.get_location_data("#{location}")
      b2 = Map.get(detail, location).source_b
      two = aggregate(b1, b2)

      %{"#{location}": %{source_a: one, source_b: two}}
    end)
  end
end
