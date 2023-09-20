defmodule WeatherAggregatorWeb.PageControllerTest do
  use WeatherAggregatorWeb.ConnCase
  
  @tag :skip
  test "GET /" do
    conn = build_conn()
    {:ok, response} = get(conn, "/page")

    assert html_response(response, 200) =~ "Page content" # Adjust the assertion as needed
  end
end
