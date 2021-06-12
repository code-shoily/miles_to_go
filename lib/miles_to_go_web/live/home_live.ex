defmodule MilesToGoWeb.HomeLive do
  @moduledoc false

  use MilesToGoWeb, :surface_view

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)
    {:ok, assign(socket, query: "", results: %{})}
  end
end
