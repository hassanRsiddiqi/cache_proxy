defmodule CacheProxy.PublisherTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias CacheProxy.Publisher

  setup_all do
    HTTPoison.start
    :ok
  end

  test "Publisher" do
    use_cassette "publisher/get_story" do
      {:ok, data} = Publisher.get()
      assert String.contains?(data, "Jerky tri-tip bacon") == true
    end
  end

end
