defmodule TicTacToe.GameServer do
  use GenServer

  alias TicTacToe.Game

  ### CLient
  def new() do
    GenServer.start_link(__MODULE__, nil)
  end

  def move(pid, move) do
    GenServer.call(pid, {:play_turn, move})
  end

  def get_state(pid) do
    GenServer.call(pid, {:state})
  end

  ### Server

  @impl true
  def init(nil) do
    Game.new()
  end

  @impl true
  def handle_call({:play_turn, move}, _from, game) do
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
