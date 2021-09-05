defmodule CacheProxyWeb.Router do
  use CacheProxyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CacheProxyWeb do
    pipe_through :api

    post "/search", SearchController, :index
  end
end
