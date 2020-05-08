defmodule TicTacToe do
  alias TicTacToe.{GameServer, GameSupervisor, GameRegistry}

  def new() do
    passcode = generate_passcode()

    {:ok, _pid} =
      DynamicSupervisor.start_child(GameSupervisor, {GameServer, name: via_tuple(passcode)})

    {:ok, passcode}
  end

  def move(passcode, space) do
    GenServer.call(via_tuple(passcode), {:move, space})
  end

  def fetch(passcode) do
    state = GenServer.call(via_tuple(passcode), {:state})
    {:ok, state}
  end

  defp generate_passcode do
    :crypto.strong_rand_bytes(8)
    |> Base.encode32(padding: false, case: :upper)
    |> binary_part(0, 8)
  end

  defp via_tuple(passcode) do
    {:via, Registry, {GameRegistry, passcode}}
  end
end
