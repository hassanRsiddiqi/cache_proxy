defmodule CacheProxyWeb.SearchView do
  use CacheProxyWeb, :view

  def render("search.json", %{story: story}) do
    %{data: render_one(story, CacheProxyWeb.SearchView, "story.json")}
  end

  def render("story.json", %{search: %{title: title, body: body, source: source}}) do
   %{title: title, body: body, source: source}
  end

end
