defmodule WeatherAggregator.WeatherApi.TomorrowIoTest do
  @moduledoc """
  This module serves as the mock module for TomorrowIO API testing.
  """

  def get_location_data(_location) do
    [
      %{
        date: ~D[2023-09-16],
        humidity: %{avg: 80.84, max: 98.7, min: 57.34},
        temperature: %{avg: 18.34, max: 24.21, min: 12.06}
      },
      %{
        date: ~D[2023-09-17],
        humidity: %{avg: 74.95, max: 98.64, min: 51.16},
        temperature: %{avg: 20.1, max: 26.02, min: 14.53}
      },
      %{
        date: ~D[2023-09-18],
        humidity: %{avg: 80.81, max: 95.21, min: 52.38},
        temperature: %{avg: 18.26, max: 25.63, min: 14.06}
      }
    ]
  end
end
