defmodule CacheProxy.Cache do
  @moduledoc """
  Module to cache publisher response.
  """
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [
      {:table_name, :cache_table},
      {:log_limit, 1_000_000}
    ], opts)
  end

  def get(slug) do
    case GenServer.call(__MODULE__, {:get, slug}) do
      [] -> {:ok, 404}
      [{_slug, result}] -> {:ok, result}
    end
  end

  def set(slug, value) do
    GenServer.call(__MODULE__, {:set, slug, value})
  end

  # GenServer callbacks
  def handle_call({:get, slug}, _from, state) do
    %{table_name: table_name} = state
    result = :ets.lookup(table_name, slug)
    {:reply, result, state}
  end

  def handle_call({:set, slug, value}, _from, state) do
    %{table_name: table_name} = state
    true = :ets.insert(table_name, {slug, value})
    {:reply, value, state}
  end

  def init(args) do
    [{:table_name, table_name}, {:log_limit, log_limit}] = args

    :ets.new(table_name, [:named_table, :set, :private])

    {:ok, %{log_limit: log_limit, table_name: table_name}}
  end
end
