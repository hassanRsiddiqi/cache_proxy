defmodule CacheProxy.Utils do
  @moduledoc """
  Utility functions to be use anywhere.
  """
  
  @doc """
  Convert a string into slug.
  """
  def get_slug(title) do
    title
    |> String.downcase()
    |> String.replace(" ", "-")
  end
end
