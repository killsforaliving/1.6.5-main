defmodule SpadesWeb.LobbyChannel do
  @moduledoc """
  Represents a channel that notifies browsers when new games are created/deleted.
  """
  use SpadesWeb, :channel
  require Logger

  def join("lobby:lobby", _payload, socket) do
    # Logger.info("Lobby Join")
    # payload |> IO.inspect(label: "lobby payload")
    # socket |> IO.inspect(label: "socket after lobby join")

    # Dialyzer making me comment htis out.. lol
    #
    # if authorized?(payload) do


    {:ok, socket}
    # else
    #   {:error, %{reason: "unauthorized"}}
    # end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (lobby:lobby).
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  def handle_in("test_message_from_javascript", _payload, socket) do
    # payload |> IO.inspect()
    # Can also send back "{:reply, :ok, socket}" or send back "{:noreply, socket}"
    {:reply, {:ok, socket.assigns}, socket}
  end

  def handle_in("get_rooms", _payload, socket) do
    rooms = Spades.Rooms.list_rooms()
    |> Enum.filter(&(&1.status == "waiting")) # Only show rooms that are waiting

    {:reply, {:ok, rooms}, socket}
  end
end

  # Add authorization logic here as required.
  # defp authorized?(_payload) do
  #   true
  # end
