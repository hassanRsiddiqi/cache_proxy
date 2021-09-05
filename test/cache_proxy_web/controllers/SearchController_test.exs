defmodule SearchControllerTest do
  use CacheProxyWeb.ConnCase

  describe "index" do
    test "get and fecth an article", %{conn: conn} do
      conn = post(conn, Routes.search_path(conn, :index),
        %{"title" => "The Current"})

      assert :proplists.get_value("content-type", conn.resp_headers) ==
        "application/json; charset=utf-8"

      %{"data" => first_call} = json_response(conn, 200)
      # Fetch Again to verify logic.

      conn = post(conn, Routes.search_path(conn, :index),
        %{"title" => "The Current"})

      %{"data" => second_call} = json_response(conn, 200)
      assert first_call["title"] == second_call["title"]
      assert first_call["body"] == second_call["body"]
      assert first_call["source"] == "Publisher"
      assert second_call["source"] == "Local Storage"
    end
  end
end
