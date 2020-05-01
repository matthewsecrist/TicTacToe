defmodule TicTacToe.Board do
  def new() do
    board =
      Enum.into(0..8, [])
      |> Enum.map(fn _ -> nil end)

    {:ok, board}
  end

  def edit(board, space, x_or_o) when space >= 0 and space <= 8 do
    with {:ok, true} <- available?(board, space) do
      new_board = List.replace_at(board, space, x_or_o)

      case check(new_board) do
        true -> {:ok, :winner, new_board}
        false -> {:ok, new_board}
      end
    else
      _ -> {:error, :invalid_move}
    end
  end

  def edit(_, _, _), do: {:error, :not_allowed}

  defp available?(board, space), do: {:ok, nil == Enum.at(board, space)}

  defp check([x, x, x | _]) when x != nil, do: true
  defp check([_, _, _, x, x, x | _]) when x != nil, do: true
  defp check([_, _, _, _, _, _, x, x, x]) when x != nil, do: true
  defp check([x, _, _, x, _, _, x, _, _]) when x != nil, do: true
  defp check([_, x, _, _, x, _, _, x, _]) when x != nil, do: true
  defp check([_, _, x, _, _, x, _, _, x]) when x != nil, do: true
  defp check([x, _, _, _, x, _, _, _, x]) when x != nil, do: true
  defp check([_, _, x, _, x, _, x, _, _]) when x != nil, do: true
  defp check(_), do: false
end
