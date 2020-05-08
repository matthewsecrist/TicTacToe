defmodule TicTacToeWeb.GameSpace do
  use TicTacToeWeb, :live_component

  def render(assigns) do
    ~L"""
      <div phx-click="move" phx-target="<%= @myself %>" class="game-space">
        <%= @space %>
      </div>
    """
  end

  def handle_event("move", _, socket) do
    %{passcode: passcode, id: id} = socket.assigns
    TicTacToe.move(passcode, id)

    :ok = Phoenix.PubSub.broadcast!(TicTacToe.PubSub, passcode, :update)

    {:noreply, socket}
  end
end
