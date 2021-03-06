defmodule MilesToGoWeb.NavUserDropDownComponent do
  @moduledoc """
  User drop-down component. Used to show user specific actions.
  """
  use MilesToGoWeb, :surface_component

  prop current_user, :map

  def render(assigns) do
    ~F"""
    <div class="navbar-end">
      <div class="navbar-item">
        <div class="navbar-item has-dropdown is-hoverable">
          <Link to="" label={@current_user.email} class="navbar-link" />
          <div class="navbar-dropdown">
            <Link label="Settings" class="navbar-item" to={Routes.user_settings_path(@socket, :edit)} />
            <div class="navbar-divider" />
            <Link
              label="Log out"
              class="navbar-item has-text-danger"
              to={Routes.user_session_path(@socket, :delete)}
              method={:delete}
            />
            <div class="navbar-divider" />
            <Link
              label="Log out from all sessions"
              class="navbar-item has-text-danger"
              to={Routes.user_session_path(@socket, :force_logout)}
              method={:delete}
            />
          </div>
        </div>
      </div>
    </div>
    """
  end
end
