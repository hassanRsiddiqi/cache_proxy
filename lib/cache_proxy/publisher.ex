defmodule CacheProxy.Publisher do
  @moduledoc """
  Module to generate random content for stories,
  Since I don't have any original publisher API,
  I'll be fetching from random data generator.
  """
  @url "https://baconipsum.com/api/?type=meat-and-filler"

  def get() do
    case HTTPoison.get(@url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:ok, 404}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
