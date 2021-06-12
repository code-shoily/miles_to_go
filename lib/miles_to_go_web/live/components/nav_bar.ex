defmodule MilesToGoWeb.NavBarComponent do
  use MilesToGoWeb, :surface_live_component

  alias MilesToGoWeb.NavBrandComponent
  alias MilesToGoWeb.NavLinkComponent
  alias MilesToGoWeb.NavUserDropDownComponent

  prop current_user, :map

  def render(assigns) do
    ~H"""
    <nav class="navbar" role="navigation" aria-label="main navigation">
      <NavBrandComponent />
      <div class="navbar-menu" id="navMenu">
        <NavLinkComponent />
        <NavUserDropDownComponent current_user={{ @current_user }} />
      </div>
    </nav>
    """
  end
end
