defmodule WeatherAggregator.Aggregator do
  alias WeatherAggregator.Aggregator.Summary
  alias WeatherAggregator.Aggregator.Detail

  def run(%{}) do
    %{
      summary: Summary.fetch_location_data(%{}),
      detail: Detail.get_each_source_separately(%{})
    }
  end

  def run(state) do
    %{
      summary: Summary.fetch_location_data(state),
      detail: Detail.get_each_source_separately(state)
    }
  end
end
