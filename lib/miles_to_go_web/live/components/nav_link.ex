defmodule MilesToGoWeb.NavLinkComponent do
  @moduledoc """
  Menulink for top-bar.
  """
  use MilesToGoWeb, :surface_component

  def render(assigns) do
    ~H"""
    <div class="navbar-end">
      <Link to="/" label="Home" class="navbar-main-link is-active" />
      <Link to="/" label="Tracks" class="navbar-main-link" />
      <Link to="/" label="People" class="navbar-main-link" />
      <Link to="/" label="Events" class="navbar-main-link" />
    </div>
    """
  end
end
