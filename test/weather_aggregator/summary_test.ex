defmodule WeatherAggregator.SummaryTest do
  use ExUnit.Case, async: true
  alias WeatherAggregator.Aggregator.Summary

  @valid_state %{
    state: %{
      london: [
        %{
          date: ~D[2023-09-16],
          humidity: %{avg: 89.37, max: 98.7, min: 57.34},
          temperature: %{avg: 44.82, max: 73.7, min: 12.06}
        },
        %{
          date: ~D[2023-09-17],
          humidity: %{avg: 85.975, max: 98.64, min: 51.16},
          temperature: %{avg: 44.8, max: 70.8, min: 14.53}
        },
        %{
          date: ~D[2023-09-18],
          humidity: %{avg: 88.405, max: 96.0, min: 52.38},
          temperature: %{avg: 44.28, max: 72.2, min: 14.06}
        }
      ],
      newyork: [
        %{
          date: ~D[2023-09-16],
          humidity: %{avg: 89.37, max: 98.7, min: 57.34},
          temperature: %{avg: 44.82, max: 73.7, min: 12.06}
        },
        %{
          date: ~D[2023-09-17],
          humidity: %{avg: 85.975, max: 98.64, min: 51.16},
          temperature: %{avg: 44.8, max: 70.8, min: 14.53}
        },
        %{
          date: ~D[2023-09-18],
          humidity: %{avg: 88.405, max: 96.0, min: 52.38},
          temperature: %{avg: 44.28, max: 72.2, min: 14.06}
        }
      ]
    }
  }

  test "return summary initially when no state" do
    res = Summary.fetch_summary_data(%{})

    assert is_map(res)
    assert Enum.count(Map.keys(res)) == 2
    assert Map.keys(res) == [:london, :newyork]
  end

  test "return summary initially when a valid state" do
    res = Summary.fetch_summary_data(@valid_state)

    assert is_map(res)
    assert Enum.count(Map.keys(res)) == 2
    assert Map.keys(res) == [:london, :newyork]
  end
end
