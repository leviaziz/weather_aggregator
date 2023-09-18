defmodule WeatherAggregatorWeb.WeatherController do
  use WeatherAggregatorWeb, :controller
  import Phoenix.Controller
  alias WeatherAggregatorWeb.Helper.DataParser

  @spec get_detail(Plug.Conn.t(), any) :: Plug.Conn.t()
  def get_detail(conn, _params) do
    case DataParser.get_detail_data() do
      {:ok, data} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(data))

      error ->
        conn
        |> put_status(:bad_request)
        |> send_resp(500, Poison.encode!(error))
    end
  end

  @spec get_summary(Plug.Conn.t(), any) :: Plug.Conn.t()
  def get_summary(conn, _params) do
    case DataParser.get_summary_data() do
      {:ok, data} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Poison.encode!(data))

      error ->
        conn
        |> put_status(:bad_request)
        |> send_resp(500, Poison.encode!(error))
    end
  end

  @spec update_summary(Plug.Conn.t(), any) :: Plug.Conn.t()
  def update_summary(conn, _params) do
    {:ok, summary} = DataParser.get_summary_data()
    {:ok, detail} = DataParser.get_detail_data()

    try do
      state = WeatherAggregator.Aggregator.run(%{summary: summary, detail: detail})
      WeatherAggregator.GenServer.update_state(state)

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
