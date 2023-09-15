defmodule WeatherAggregator.Request do
  @moduledoc """
  The Request module is used to make requests and handle responses from the client service API
  """
  require Logger
  use HTTPoison.Base

  @headers [
    {"Content-type", "application/json"}
  ]

  def get_request(url, header \\ []) do
    url
    |> HTTPoison.get(header ++ @headers)
    |> res_http()
    |> decode_response()
  end

  defp res_http({:ok, %HTTPoison.Response{status_code: 200, body: body}}), do: body
  defp res_http(_), do: {:error, "Third-party API Failing"}

  defp decode_response({:error, message}) do
    Logger.error(message)
    {:error, message}
  end

  defp decode_response(response) do
    case Poison.decode(response) do
      {:ok, result} ->
        result

      {:error, result} ->
        Logger.error(result)
        {:error, result}
    end
  end
end
