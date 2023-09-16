defmodule WeatherAggregator.WeatherApi.VisualCrossingTest do
  def get_location_data(location) do
    [
      %{
        date: ~D[2023-09-16],
        humidity: %{avg: 97.9, max: 97.9, min: 97.9},
        temperature: %{avg: 71.3, max: 73.7, min: 68.8}
      },
      %{
        date: ~D[2023-09-17],
        humidity: %{avg: 97.0, max: 97.0, min: 97.0},
        temperature: %{avg: 69.5, max: 70.8, min: 68.3}
      },
      %{
        date: ~D[2023-09-18],
        humidity: %{avg: 96.0, max: 96.0, min: 96.0},
        temperature: %{avg: 70.3, max: 72.2, min: 67.9}
      }
    ]
  end
end
