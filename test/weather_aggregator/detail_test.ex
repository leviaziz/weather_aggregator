defmodule WeatherAggregator.DetailTest do
  use ExUnit.Case, async: true
  alias WeatherAggregator.Aggregator.Detail

  @valid_detail %{
    details: [
      %{
        newyork: %{
          source_a: [
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
          ],
          source_b: [
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
        }
      },
      %{
        london: %{
          source_a: [
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
          ],
          source_b: [
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
        }
      }
    ]
  }

  test "return detail initially when no detail in state" do
    res = Detail.get_each_source_separately(%{})

    assert is_list(res)
    assert Enum.count(res) == 2
  end

  test "return detail initially when a detail in state" do
    res = Detail.get_each_source_separately(@valid_detail)

    assert is_list(res)
    assert Enum.count(res) == 2
  end
end
