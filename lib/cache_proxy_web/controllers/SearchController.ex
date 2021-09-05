defmodule CacheProxyWeb.SearchController do
  use CacheProxyWeb, :controller

  alias CacheProxy.{
    Cache,
    Publisher,
    Utils,
  }

  def index(conn, params) do
    slug = params["title"]
      |> Utils.get_slug()

    story =
      case Cache.get(slug) do
        {:ok, 404} -> get_from_publisher(params, slug)
        {:ok, story} -> story |> Map.put(:source, "Local Storage")
      end

    conn
    |> put_resp_content_type("application/json")
    |> render("search.json", story: story)
  end

  defp get_from_publisher(params, slug) do
    response = %{
      title: params["title"],
      source: "Publisher"
    }

    case Publisher.get() do
      {:ok, 404} ->
        Map.put(response, :body, "No result found (404)")

      {:ok, body} ->
        response = Map.put(response, :body, body)
        Cache.set(slug, response)

        response

      {:error, _error} ->
        Map.put_new(response, :error, "Error! while fetching data from publisher.")
     end
  end

end
