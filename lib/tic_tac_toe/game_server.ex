defmodule TicTacToe.GameServer do
  use GenServer

  alias TicTacToe.Game

  ### CLient
  def start_link(opts) do
    {:ok, game} = Game.new()
    GenServer.start_link(__MODULE__, game, opts)
  end

  @impl true
  def init(game) do
    {:ok, game}
  end

  @impl true
  def handle_call({:move, move}, _from, game) do
    with {:ok, new_state} <- Game.move(game, move) do
      {:reply, new_state, new_state}
    else
      _ -> {:reply, {:error, :bad_move}, game}
    end
  end

  @impl true
  def handle_call({:state}, _from, game) do
    {:reply, game, game}
  end
end
