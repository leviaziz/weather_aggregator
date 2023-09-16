defmodule WeatherAggregatorWeb.WeatherController do
  use WeatherAggregatorWeb, :controller
  import Phoenix.Controller
  alias WeatherAggregatorWeb.Helper.DataParser

  def get_detail(conn, _params) do
    case DataParser.get_detail_data() do
    data ->
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(data))
    {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> send_resp(500, Poison.encode!(reason))
    end

  end

  def get_summary(conn, _params) do
    case DataParser.get_summary_data() do
    {:ok, data} ->
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Poison.encode!(data))
    {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> send_resp(500, Poison.encode!(reason))
    end

  end

  def update_summary(conn, _params) do
    try do
      state = WeatherAggregator.Aggregator.run(%{})    
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, "State update successfully!")
    catch
      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> send_resp(500, Poison.encode!(reason))
    end
  end

end
