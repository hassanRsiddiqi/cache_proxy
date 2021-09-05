defmodule CacheProxy.UtilsTest do
  use ExUnit.Case

  alias CacheProxy.Utils

  test "get_slug/1 get slug from string" do
    assert Utils.get_slug("Times of Islamabad") == "times-of-islamabad"
    assert Utils.get_slug("CACHE PROXY") == "cache-proxy"
  end
end
