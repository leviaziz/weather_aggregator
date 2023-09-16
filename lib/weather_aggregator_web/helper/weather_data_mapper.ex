defmodule WeatherAggregatorWeb.Helper.WeatherDataMapper do
  def from_json(json) do
      map_data(json)
  end

  defp map_data(data) do
    IO.inspect(data)
    %WeatherAggregatorWeb.Helper.WeatherData{
      detail: [
      newyork: map_location(data, "newyork"),
      london: map_location(data, "london")
      ]
    }
  end

  defp map_location(data, location) do
    %{
      source_b: map_source(data, location, "source_b"),
      source_a: map_source(data, location, "source_a")
    }
  end

  defp map_source(data, location, source) do
    data
    |> Map.get(location, %{})
    |> Map.get(source, [])
    |> Enum.map(&map_source_entry(&1))
  end

  defp map_source_entry(entry) do
    %{
      temperature: %{
        min: entry["temperature"]["min"],
        max: entry["temperature"]["max"],
        avg: entry["temperature"]["avg"]
      },
      humidity: %{
        min: entry["humidity"]["min"],
        max: entry["humidity"]["max"],
        avg: entry["humidity"]["avg"]
      },
      date: entry["date"]
    }
  end
end
