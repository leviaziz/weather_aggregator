defmodule WeatherAggregatorWeb.Helper.DataParser do
  @spec get_data :: {:ok, any}
  def get_data() do
    case WeatherAggregator.GenServer.get_state() do
      nil -> {:ok, %{}}
      data -> {:ok, data}
    end
  end

  @spec get_detail_data :: {:ok, list}
  def get_detail_data() do
    case get_data() do
      {:ok, weather_data} ->
        {:ok, weather_data[:detail]}

      error ->
        error
    end
  end

  @spec get_summary_data :: {:ok, map}
  def get_summary_data() do
    case get_data() do
      {:ok, weather_data} ->
        {:ok, weather_data[:summary]}

      error ->
        error
    end
  end
end
