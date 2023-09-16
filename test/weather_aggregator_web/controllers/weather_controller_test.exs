defmodule WeatherAggregatorWeb.WeatherControllerTest do
  use WeatherAggregatorWeb.ConnCase

  describe "get_detail/2" do
    test "returns detail data when successful", %{conn: conn} do
      {:ok, detail_data} = DataParser.get_detail_data()

      conn = get(conn, Routes.weather_path(conn, :get_detail))

      assert conn.status == 200
      assert json_response(conn, detail_data) == detail_data
    end

    test "returns a 500 error response on failure", %{conn: conn} do
      {:error, reason} = {:error, "Some error message"}

      allow(DataParser).to receive(:get_detail_data) |> fn _ -> {:error, reason} end

      conn = get(conn, Routes.weather_path(conn, :get_detail))

      assert conn.status == 500
      assert json_response(conn, reason) == reason
    end
  end

  describe "get_summary/2" do
    test "returns summary data when successful", %{conn: conn} do
      {:ok, summary_data} = DataParser.get_summary_data()

      conn = get(conn, Routes.weather_path(conn, :get_summary))

      assert conn.status == 200
      assert json_response(conn, summary_data) == summary_data
    end

    test "returns a 500 error response on failure", %{conn: conn} do
      {:error, reason} = {:error, "Some error message"}

      allow(DataParser).to receive(:get_summary_data) |> fn _ -> {:error, reason} end

      conn = get(conn, Routes.weather_path(conn, :get_summary))

      assert conn.status == 500
      assert json_response(conn, reason) == reason
    end
  end

  describe "update_summary/2" do
    test "returns success message when successful", %{conn: conn} do
      allow(WeatherAggregator.Aggregator).to receive(:run) |> fn _ -> {:ok, %{}} end

      conn = post(conn, Routes.weather_path(conn, :update_summary))

      assert conn.status == 200
      assert json_response(conn, "State update successfully!") == "State update successfully!"
    end

    test "returns a 500 error response on failure", %{conn: conn} do
      allow(WeatherAggregator.Aggregator).to receive(:run) |> fn _ -> {:error, "Some error message"} end

      conn = post(conn, Routes.weather_path(conn, :update_summary))

      assert conn.status == 500
      assert json_response(conn, "Some error message") == "Some error message"
    end
  end
end
