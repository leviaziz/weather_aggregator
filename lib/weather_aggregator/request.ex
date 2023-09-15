defmodule WeatherAggregator.Request do
  @moduledoc """
  The Request module is used to make requests and handle responses from the client service API
  """
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
  defp res_http({:ok, %HTTPoison.Response{status_code: 201, body: body}}), do: body
  defp res_http({:ok, %HTTPoison.Response{status_code: 202, body: body}}), do: body
  defp res_http({:ok, %HTTPoison.Response{status_code: 204, body: body}}), do: body
  defp res_http({:error, :timeout}), do: {:error, "Timeout"}
  defp res_http({:error, %HTTPoison.Error{reason: reason}}), do: reason
  defp res_http({:ok, %HTTPoison.Response{status_code: 400, body: body}}), do: body
  defp res_http({:ok, %HTTPoison.Response{status_code: 401, body: body}}), do: body
  defp res_http({:ok, %HTTPoison.Response{status_code: 402, body: body}}), do: body
  defp res_http({:ok, %HTTPoison.Response{status_code: 403, body: body}}), do: body
  defp res_http({:ok, %HTTPoison.Response{status_code: 404, body: body}}), do: body
  defp res_http({:ok, %HTTPoison.Response{status_code: 415, body: body}}), do: body
  defp res_http({:ok, %HTTPoison.Response{status_code: 422, body: body}}), do: body
  defp res_http({:ok, %HTTPoison.Response{status_code: 429, body: body}}), do: body
  defp res_http({:ok, %HTTPoison.Response{status_code: 500, body: body}}), do: body
  defp res_http({:ok, %HTTPoison.Response{status_code: 502, body: body}}), do: body
  defp res_http({:ok, %HTTPoison.Response{status_code: 503, body: body}}), do: body
  defp res_http({:ok, %HTTPoison.Response{status_code: 504, body: body}}), do: body
  defp res_http(error), do: error

  defp decode_response(response) do
    case Poison.decode(response) do
      {:ok, result} -> result
      {:error, result} -> {:error, result}
    end
  end
end
