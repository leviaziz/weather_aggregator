defmodule WeatherAggregatorWeb.Helper.WeatherData do
  defstruct summary: %{
              newyork: [%{}],
              london: [%{}]
            },
            detail: [%{}]
end

defmodule LocationData do
  defstruct temperature: %{},
            humidity: %{},
            date: ""
end
