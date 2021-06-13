defmodule MilesToGoWeb.NavUserDropDownComponent do
  @moduledoc """
  User drop-down component. Used to show user specific actions.
  """
  use MilesToGoWeb, :surface_component

  alias Surface.Components.LivePatch

  prop current_user, :map

  def render(assigns) do
    ~H"""
    <div class="navbar-end">
      <div class="navbar-item">
        <div class="navbar-item has-dropdown is-hoverable">
          <Link to="" label={{ @current_user.email }} class="navbar-link" />
          <div class="navbar-dropdown">
            <LivePatch label="Settings" class="navbar-item" to="/user/settings" />
            <div class="navbar-divider" />
            <Link
              label="Log Out"
              class="navbar-item has-text-danger"
              to={{ Routes.user_session_path(@socket, :delete) }}
              opts={{ method: :delete }}
            />
          </div>
        </div>
      </div>
    </div>
    """
  end
end
