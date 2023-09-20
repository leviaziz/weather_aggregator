defmodule WeatherAggregatorWeb.WeatherControllerTest do
  use ExUnit.Case

  alias WeatherAggregatorWeb.WeatherController

  setup do
    {:ok, _pid} = WeatherAggregator.GenServer.start_link(%{})
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end

  test "get_detail returns successful response when DataParser returns {:ok, data}", %{conn: conn} do
    conn = WeatherController.get_detail(conn, %{})
    assert conn.status == 200
  end

  test "get_summary returns successful response when DataParser returns {:ok, data}", %{
    conn: conn
  } do
    conn = WeatherController.get_summary(conn, %{})
    assert conn.status == 200
  end

  test "update store data returns returns {:ok, message}", %{
    conn: conn
  } do
    conn = WeatherController.update_summary(conn, %{})

    assert conn.status == 200
  end
end
