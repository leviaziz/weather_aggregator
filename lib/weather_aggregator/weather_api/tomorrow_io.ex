defmodule WeatherAggregator.WeatherApi.TomorrowIo do
  alias WeatherAggregator.Request

  @api_key System.get_env("TOMORROW_IO_API_KEY")
  @base_url System.get_env("TOMORROW_IO_URL")

  @type forecast :: %{
          date: Date.t(),
          humidity: %{
            min: float,
            max: float,
            avg: float
          },
          temperature: %{
            min: float,
            max: float,
            avg: float
          }
        }

  @spec get_location_data(binary()) :: list(forecast())
  def get_location_data(location) do
    case "#{@base_url}?location=#{location}&apikey=#{@api_key}&timesteps=1d&units=imperial"
         |> Request.get_request() do
      {:error, _} -> []
      data -> get_three_days_data(data["timelines"]["daily"])
    end
  end

  defp get_three_days_data(days) do
    days_required =
      for range <- 1..3 do
        Date.utc_today() |> Date.add(range)
      end

    Enum.map(days, fn day ->
      {:ok, datetime, 0} = DateTime.from_iso8601(day["time"])
      date = DateTime.to_date(datetime)

      if date in days_required do
        %{
          date: date,
          humidity: %{
            min: day["values"]["humidityMin"],
            max: day["values"]["humidityMax"],
            avg: day["values"]["humidityAvg"]
          },
          temperature: %{
            min: day["values"]["temperatureMin"],
            max: day["values"]["temperatureMax"],
            avg: day["values"]["temperatureAvg"]
          }
        }
      end
    end)
    |> Enum.reject(&is_nil(&1))
  end
end
