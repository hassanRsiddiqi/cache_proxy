defmodule CacheProxy.CacheSupervisor do
  @moduledoc false

  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
      {CacheProxy.Cache, name: CacheProxy.Cache},
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
