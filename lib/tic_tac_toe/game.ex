defmodule TicTacToe.Game do
  defstruct board: nil,
            current_player: "x",
            game_over: false

  alias TicTacToe.Board

  def new() do
    {:ok, board} = Board.new()
    {:ok, %__MODULE__{board: board}}
  end

  def move(%__MODULE__{game_over: true}, _), do: {:error, :game_over}

  def move(%__MODULE__{board: board, current_player: current_player} = game, position) do
    with {:ok, new_board} <- Board.edit(board, position, current_player) do
      next_player = switch_player(current_player)
      {:ok, %__MODULE__{board: new_board, current_player: next_player}}
    else
      {:ok, :winner, new_board} ->
        {:ok, %__MODULE__{board: new_board, current_player: nil, game_over: true}}

      {:ok, _} ->
        {:error, :something_else_happened_here}

      _ ->
        {:error, game}
    end
  end

  defp switch_player("x"), do: "o"
  defp switch_player(_), do: "x"
end
