defmodule CacheProxy.CacheTest do
  use ExUnit.Case

  alias CacheProxy.Cache

  test "caches and finds the correct data" do
    assert Cache.set("times_of_islamabad", "Times of Islamabad") == "Times of Islamabad"
    assert Cache.get("times_of_islamabad") == {:ok, "Times of Islamabad"}
  end
end
