defmodule MilesToGoWeb.NavUserDropDownComponent do
  use MilesToGoWeb, :surface_component

  prop current_user, :map

  def render(assigns) do
    ~H"""
    <div class="navbar-end">
      <div class="navbar-item">
        <div class="navbar-item has-dropdown is-hoverable">
          <Link to="" label={{ @current_user.name }} class="navbar-link" />
          <div class="navbar-dropdown">
            <Link label="Settings" class="navbar-item" to={{ Routes.user_settings_path(@socket, :edit) }} />
            <div class="navbar-divider" />
            <Link
              label="Log out"
              class="navbar-item has-text-danger"
              to={{ Routes.user_session_path(@socket, :delete) }}
              opts={{ method: :delete }}
            />
            <div class="navbar-divider" />
            <Link
              label="Log out from all sessions"
              class="navbar-item has-text-danger"
              to={{ Routes.user_session_path(@socket, :force_logout) }}
              opts={{ method: :delete }}
            />
          </div>
        </div>
      </div>
    </div>
    """
  end
end
