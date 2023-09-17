defmodule WeatherAggregatorWeb.WeatherControllerIntegrationTest do
  use WeatherAggregatorWeb.ConnCase
  alias WeatherAggregatorWeb.Router.Helpers, as: Routes
  import Phoenix.ConnTest

  describe "GET /weather/detail" do
    test "returns detail data when successful", %{conn: conn} do
      conn = get(conn, Routes.weather_path(conn, :get_detail))

      assert conn.status == 200
      assert Jason.decode!(conn.resp_body) == {:ok, expected_detail_data}
    end

    test "returns a 500 error response on failure", %{conn: conn} do
      allow(DataParser).to(
        receive(:get_detail_data)
        |> fn _ -> {:error, "Some error message"} end
      )

      conn = get(conn, Routes.weather_path(conn, :get_detail))

      assert conn.status == 500
      assert Jason.decode!(conn.resp_body) == {:error, "Some error message"}
    end
  end

  describe "GET /weather/summary" do
    test "returns summary data when successful", %{conn: conn} do
      conn = get(conn, Routes.weather_path(conn, :get_summary))

      assert conn.status == 200
      assert Jason.decode!(conn.resp_body) == {:ok, expected_summary_data}
    end

    test "returns a 500 error response on failure", %{conn: conn} do
      allow(DataParser).to(
        receive(:get_summary_data)
        |> fn _ -> {:error, "Some error message"} end
      )

      conn = get(conn, Routes.weather_path(conn, :get_summary))

      assert conn.status == 500
      assert Jason.decode!(conn.resp_body) == {:error, "Some error message"}
    end
  end

  describe "POST /weather/update_summary" do
    test "returns success message when successful", %{conn: conn} do
      allow(WeatherAggregator.Aggregator).to(receive(:run) |> fn _ -> {:ok, %{}} end)

      conn = post(conn, Routes.weather_path(conn, :update_summary))

      assert conn.status == 200
      assert Jason.decode!(conn.resp_body) == "State update successfully!"
    end

    test "returns a 500 error response on failure", %{conn: conn} do
      allow(WeatherAggregator.Aggregator).to(
        receive(:run)
        |> fn _ -> {:error, "Some error message"} end
      )

      conn = post(conn, Routes.weather_path(conn, :update_summary))

      assert conn.status == 500
      assert Jason.decode!(conn.resp_body) == {:error, "Some error message"}
    end
  end
end
