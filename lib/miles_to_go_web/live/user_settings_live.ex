defmodule MilesToGoWeb.UserSettingsLive do
  @moduledoc """
  Component for user settings and preferences.
  """
  use MilesToGoWeb, :surface_view

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)
    {:ok, socket}
  end
end
