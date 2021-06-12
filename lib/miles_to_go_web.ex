defmodule MilesToGoWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use MilesToGoWeb, :controller
      use MilesToGoWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: MilesToGoWeb

      import Plug.Conn
      import MilesToGoWeb.Gettext
      alias MilesToGoWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/miles_to_go_web/templates",
        namespace: MilesToGoWeb

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {MilesToGoWeb.LayoutView, "live.html"}

      unquote(view_helpers())
      unquote(live_view_helpers())
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent

      unquote(view_helpers())
      unquote(live_view_helpers())
    end
  end

  def surface_view do
    quote do
      use Surface.LiveView,
        layout: {MilesToGoWeb.LayoutView, "live.html"}

      unquote(view_helpers())
      unquote(live_view_helpers())
    end
  end

  def surface_live_component do
    quote do
      use Surface.Component

      unquote(view_helpers())
      unquote(live_view_helpers())
    end
  end

  def surface_component do
    quote do
      use Surface.Component

      unquote(view_helpers())
      unquote(live_view_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import MilesToGoWeb.Gettext
    end
  end

  defp view_helpers do
    quote do
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      # Import LiveView helpers (live_render, live_component, live_patch, etc)
      import Phoenix.LiveView.Helpers

      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      import MilesToGoWeb.Bulma.FormHelpers
      import MilesToGoWeb.ErrorHelpers
      import MilesToGoWeb.Gettext
      alias MilesToGoWeb.Router.Helpers, as: Routes
    end
  end

  defp live_view_helpers do
    quote do
      alias Surface.Components.Link

      import MilesToGoWeb.LiveHelpers

      alias MilesToGo.Accounts
      alias MilesToGo.Accounts.User

      def handle_info(%{event: "logout_user", payload: %{user: %User{id: id}}}, socket) do
        case socket.assigns.current_user do
          %User{id: ^id} = user ->
            Accounts.logout_user(user)
            {:noreply, redirect(socket, to: Routes.user_session_path(socket, :new))}

          _ ->
            {:noreply, socket}
        end
      end
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
