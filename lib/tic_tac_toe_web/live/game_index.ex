defmodule TicTacToeWeb.GameIndex do
  use Phoenix.LiveView

  alias TicTacToeWeb.GameLive
  alias TicTacToeWeb.Router.Helpers

  @impl true
  def render(assigns) do
    TicTacToeWeb.GameView.render("index.html", assigns)
  end

  @impl true
  def handle_event("new", _, socket) do
    with {:ok, passcode} <- TicTacToe.new() do
      {:noreply,
       socket
       |> put_flash(:info, "game created")
       |> redirect(to: Helpers.live_path(TicTacToeWeb.Endpoint, GameLive, passcode))}
    end
  end
end
