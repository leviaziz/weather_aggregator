defmodule WeatherAggregator.WeatherApi.VisualCrossing do
  alias WeatherAggregator.Request

  @api_key System.get_env("VISUAL_CROSSIGN_API_KEY")
  @base_url System.get_env("VISUAL_CROSSIGN_URL")

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
    case "#{@base_url}/#{location}?unitGroup=us&include=days&key=#{@api_key}&contentType=json"
         |> Request.get_request() do
      {:error, _} -> []
      data -> get_three_days_data(data["days"])
    end
  end

  defp get_three_days_data(days) do
    days_required =
      for range <- 1..3 do
        Date.utc_today() |> Date.add(range)
      end

    Enum.map(days, fn day ->
      {:ok, date} = Date.from_iso8601(day["datetime"])

      if date in days_required do
        %{
          date: date,
          humidity: %{
            min: day["humidity"],
            max: day["humidity"],
            avg: day["humidity"]
          },
          temperature: %{
            min: day["tempmin"],
            max: day["tempmax"],
            avg: day["temp"]
          }
        }
      end
    end)
    |> Enum.reject(&is_nil(&1))
  end
end
