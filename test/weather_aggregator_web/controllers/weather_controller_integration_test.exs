defmodule WeatherAggregatorWeb.WeatherControllerIntegrationTest do
  use ExUnit.Case, async: true
  use Plug.Test
  alias WeatherAggregatorWeb.Router

  setup do
    {:ok, _pid} = WeatherAggregator.GenServer.start_link(%{})
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end

  @opts Router.init([])
  test 'get Details API' do
    conn = conn(:get, "/api/weather/detail")
    response = Router.call(conn, @opts)
    assert response.status == 200
  end

  @opts Router.init([])
  test 'get Summary API' do
    conn = conn(:get, "/api/weather/summary")
    response = Router.call(conn, @opts)
    assert response.status == 200
  end

  @opts Router.init([])
  test 'Update Summary API' do
    conn = conn(:post, "/api/weather/update", %{})
    response = Router.call(conn, @opts)
    assert response.status == 200
  end
end