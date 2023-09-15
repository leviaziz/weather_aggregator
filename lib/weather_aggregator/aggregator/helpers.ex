defmodule WeatherAggregator.Aggregator.Helpers do
  @spec aggregate(list, list) :: any
  def aggregate([], []), do: []
  def aggregate([], src_b), do: src_b
  def aggregate(src_a, []), do: src_a
  def aggregate(src_a, src_b), do: do_aggregate(src_a, src_b)

  defp do_aggregate(src_a, src_b) do
    Enum.map(src_a, fn a ->
      b = Enum.find(src_b, nil, &(&1.date == a.date))

      %{
        date: a.date,
        humidity: %{
          min: find_min(a[:humidity][:min], b[:humidity][:min]),
          max: find_max(a[:humidity][:max], b[:humidity][:max]),
          avg: find_avg(a[:humidity][:avg], b[:humidity][:avg])
        },
        temperature: %{
          min: find_min(a[:temperature][:min], b[:temperature][:min]),
          max: find_max(a[:temperature][:max], b[:temperature][:max]),
          avg: find_avg(a[:temperature][:avg], b[:temperature][:avg])
        }
      }
    end)
  end

  defp find_min(a, nil), do: a
  defp find_min(nil, b), do: b
  defp find_min(a, b) when a > b, do: b
  defp find_min(a, b) when a < b, do: a
  defp find_min(a, b) when a == b, do: a

  defp find_min(a, nil), do: a
  defp find_min(nil, b), do: b
  defp find_max(a, b) when a == b, do: a
  defp find_max(a, b) when a > b, do: a
  defp find_max(a, b) when a < b, do: b

  defp find_avg(a, nil), do: a
  defp find_avg(nil, b), do: b
  defp find_avg(a, b) when a == b, do: a
  defp find_avg(a, b), do: (a + b) / 2
end
