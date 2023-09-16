defmodule WeatherAggregator.Aggregator.Detail do
  import WeatherAggregator.Aggregator.Helpers

  @spec get_each_source_separately(map) :: list
  def get_each_source_separately(%{}) do
    locations = ["newyork", "london"]

    Enum.map(locations, fn location ->
      one = tomorrow_io_module().get_location_data(location)
      two = visual_crossing_module().get_location_data(location)
      %{"#{location}": %{source_a: one, source_b: two}}
    end)
  end

  def get_each_source_separately(%{detail: details}) do
    Enum.map(details, fn detail ->
      [location] = Map.keys(detail)

      a1 = tomorrow_io_module().get_location_data("#{location}")
      a2 = Map.get(detail, location).source_a
      one = aggregate(a1, a2)

      b1 = visual_crossing_module().get_location_data("#{location}")
      b2 = Map.get(detail, location).source_b
      two = aggregate(b1, b2)

      %{"#{location}": %{source_a: one, source_b: two}}
    end)
  end

  defp tomorrow_io_module do
    Application.get_env(:weather_aggregator, :tomorrow_io)
  end

  defp visual_crossing_module do
    Application.get_env(:weather_aggregator, :visual_crossing)
  end
end
