defmodule TicTacToe.RegistryServer do
  use GenServer

  @name RegistryServer

  alias TicTacToe.GameServer

  # Client
  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: @name)
  end

  def lookup(passcode) do
    GenServer.call(@name, {:lookup, passcode})
  end

  def create(passcode) do
    GenServer.call(@name, {:create, passcode})
  end

  # Server
  @impl true
  def init(:ok) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:lookup, passcode}, _from, games) do
    {:reply, Map.fetch(games, passcode), games}
  end

  @impl true
  def handle_call({:create, passcode}, _from, games) do
    if Map.has_key?(games, passcode) do
      {:reply, Map.fetch(games, passcode), games}
    else
      {:ok, pid} = GameServer.new()
      new_state = Map.put(games, passcode, pid)
      game = GameServer.get_state(pid)

      {:reply, {:ok, {passcode, game}}, new_state}
    end
  end
end
