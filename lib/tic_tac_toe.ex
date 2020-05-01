defmodule TicTacToe do
  alias TicTacToe.{GameServer, RegistryServer}

  def new() do
    passcode = generate_passcode()
    RegistryServer.create(passcode)
  end

  def move(passcode, space) do
    {:ok, pid} = RegistryServer.lookup(passcode)
    GameServer.move(pid, space)
  end

  defp generate_passcode do
    :crypto.strong_rand_bytes(8)
    |> Base.encode32(padding: false, case: :upper)
    |> binary_part(0, 8)
  end
end
