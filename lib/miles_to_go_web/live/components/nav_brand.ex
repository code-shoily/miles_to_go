defmodule MilesToGoWeb.NavBrandComponent do
  @moduledoc """
  Brand component.
  """
  use MilesToGoWeb, :surface_component

  def render(assigns) do
    ~F"""
    <div class="navbar-brand">
      <a class="navbar-item" href="">
        <span class="title is-4">
          <span class="has-text-primary">Miles</span>
          to Go...
        </span>
      </a>
      <a
        role="button"
        class="navbar-burger"
        aria-label="menu"
        aria-expanded="false"
        data-target="navMenu"
      >
        <span aria-hidden="true" />
        <span aria-hidden="true" />
        <span aria-hidden="true" />
      </a>
    </div>
    """
  end
end
