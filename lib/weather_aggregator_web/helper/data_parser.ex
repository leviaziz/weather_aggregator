defmodule WeatherAggregatorWeb.Helper.DataParser do
  alias WeatherAggregatorWeb.Helper.WeatherDataMapper

  def get_data() do
    case WeatherAggregator.GenServer.get_state() do
      nil -> {:ok, %{}}
      data -> {:ok, data}
    end
  end

  def get_detail_data() do
    case get_data() do
      {:ok, weather_data} ->
        {:ok, weather_data[:detail]}

      error ->
        error
    end
  end

  def get_summary_data() do
    case get_data() do
      {:ok, weather_data} ->
        {:ok, weather_data[:summary]}

      error ->
        error
    end
  end
end
