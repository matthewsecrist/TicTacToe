defmodule BoardTest do
  use ExUnit.Case

  alias TicTacToe.Board

  test "creates a new board" do
    board = [nil, nil, nil, nil, nil, nil, nil, nil, nil]

    assert Board.new() == {:ok, board}
  end

  test "edits board" do
    {:ok, board} = Board.new()

    new_board = [nil, nil, nil, "x", nil, nil, nil, nil, nil]

    assert Board.edit(board, 3, "x") === {:ok, new_board}
  end

  test "checks winner, winner true, horizontal" do
    board = ["x", "x", nil, nil, nil, nil, nil, nil, nil]

    new_board = ["x", "x", "x", nil, nil, nil, nil, nil, nil]

    assert Board.edit(board, 2, "x") == {:ok, :winner, new_board}
  end

  test "checks winner, winner true, vertical" do
    board = ["x", nil, nil, "x", nil, nil, nil, nil, nil]

    new_board = ["x", nil, nil, "x", nil, nil, "x", nil, nil]

    assert Board.edit(board, 6, "x") == {:ok, :winner, new_board}
  end

  test "checks winner, winner true, diagonal top to bottom" do
    board = ["x", nil, nil, nil, "x", nil, nil, nil, nil]

    new_board = ["x", nil, nil, nil, "x", nil, nil, nil, "x"]

    assert Board.edit(board, 8, "x") == {:ok, :winner, new_board}
  end

  test "checks winner, winner true, diagonal bottom to top" do
    board = [nil, nil, "x", nil, "x", nil, nil, nil, nil]

    new_board = [nil, nil, "x", nil, "x", nil, "x", nil, nil]

    assert Board.edit(board, 6, "x") == {:ok, :winner, new_board}
  end

  test "checks winner, winner false" do
    board = [nil, nil, "x", nil, "o", nil, "x", nil, nil]

    new_board = [nil, nil, "x", nil, "o", nil, "x", nil, "x"]

    assert Board.edit(board, 8, "x") == {:ok, new_board}
  end
end
