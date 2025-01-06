defmodule SpadesWeb.RoomView do
  use SpadesWeb, :view
  alias SpadesWeb.RoomView

  def render("index.json", %{rooms: rooms}) do
    %{data: render_many(rooms, RoomView, "room.json")}
  end

  def render("show.json", %{room: room}) do
    %{data: render_one(room, RoomView, "room.json")}
  end

  def render("room.json", %{room: room}) do
    %{
      id: room.id,
      name: room.name,
      is_started: room.is_started,
      slug: room.slug,
      west: room.west,
      east: room.east,
      south: room.south,
      north: room.north
    }
  end
end
