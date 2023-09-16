defmodule WeatherAggregator.HelpersTest do
  use ExUnit.Case, async: true
  alias WeatherAggregator.Aggregator.Helpers

  @valid_source_a [
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

  @valid_source_b [
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

  test "test aggregator function with both empty list" do
    assert Helpers.aggregate([], []) == []
  end

  test "test aggregator function with one is empty list as second arg" do
    assert Helpers.aggregate([a: 1], []) == [a: 1]
  end

  test "test aggregator function with one is empty list as first arg" do
    assert Helpers.aggregate([], b: 2) == [b: 2]
  end

  test "test aggregator function with correct lists" do
    result = Helpers.aggregate(@valid_source_a, @valid_source_b)

    assert is_list(result)

    assert result == [
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
  end

  test "test min, max, avg functions" do
    list_a = [
      %{
        date: ~D[2023-09-16],
        humidity: %{avg: 100.0, max: 75.02, min: 10.02},
        temperature: %{avg: 50.0, max: 50.0, min: 50.0}
      }
    ]

    list_b = [
      %{
        date: ~D[2023-09-16],
        humidity: %{avg: 0.0, max: 75.01, min: 10.01},
        temperature: %{avg: 50.0, max: 50.0, min: 50.0}
      }
    ]

    result = Helpers.aggregate(list_a, list_b) |> hd()
    assert result[:humidity][:avg] == 50.0
    assert result[:humidity][:max] == 75.02
    assert result[:humidity][:min] == 10.01
    assert result[:temperature][:avg] == 50.0
    assert result[:temperature][:max] == 50.0
    assert result[:temperature][:min] == 50.0
  end
end
