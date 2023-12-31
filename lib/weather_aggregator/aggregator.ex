defmodule WeatherAggregator.Aggregator do
  alias WeatherAggregator.Aggregator.Summary
  alias WeatherAggregator.Aggregator.Detail

  @spec run(map) :: %{summary: map(), detail: list()}
  def run(%{}) do
    %{
      summary: Summary.fetch_summary_data(%{}),
      detail: Detail.get_each_source_separately(%{})
    }
  end

  def run(state) do
    %{
      summary: Summary.fetch_summary_data(state),
      detail: Detail.get_each_source_separately(state)
    }
  end
end
