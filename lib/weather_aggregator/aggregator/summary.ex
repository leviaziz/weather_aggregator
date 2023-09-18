defmodule WeatherAggregator.Aggregator.Summary do
  import WeatherAggregator.Aggregator.Helpers

  @spec fetch_summary_data(map) :: map
  def fetch_summary_data(%{}) do
    locations = [System.get_env("WA_LOCATION_A"), System.get_env("WA_LOCATION_B")]

    res =
      Enum.map(locations, fn location ->
        one = tomorrow_io_module().get_location_data(location)
        two = visual_crossing_module().get_location_data(location)
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
        one = tomorrow_io_module().get_location_data("#{location}")
        two = visual_crossing_module().get_location_data("#{location}")

        from_sources = aggregate(one, two)
        %{"#{location}": aggregate(from_sources, list)}
      end)

    [map1] = tl(res)

    hd(res)
    |> Map.merge(map1)
  end

  defp tomorrow_io_module do
    Application.get_env(:weather_aggregator, :tomorrow_io)
  end

  defp visual_crossing_module do
    Application.get_env(:weather_aggregator, :visual_crossing)
  end
end
