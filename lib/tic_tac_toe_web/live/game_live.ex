defmodule TicTacToeWeb.GameLive do
  use Phoenix.LiveView

  @impl true
  def render(assigns) do
    TicTacToeWeb.GameView.render("game.html", assigns)
  end

  @impl true
  def mount(%{"passcode" => passcode}, _, socket) do
    :ok = Phoenix.PubSub.subscribe(TicTacToe.PubSub, passcode)
    {:ok, game} = TicTacToe.fetch(passcode)

    {:ok,
     socket
     |> assign(:game, game)
     |> assign(:passcode, passcode)}
  end

  @impl true
  def handle_info(:update, socket) do
    {:ok, game} = TicTacToe.fetch(socket.assigns.passcode)
    {:noreply, assign(socket, game: game)}
  end
end
