defmodule MilesToGoWeb.LiveHelpers do
  @moduledoc false

  import Phoenix.LiveView

  alias MilesToGo.Accounts
  alias MilesToGo.Accounts.User
  alias MilesToGoWeb.Router.Helpers, as: Routes
  alias MilesToGoWeb.UserAuth

  def assign_defaults(session, socket) do
    MilesToGoWeb.Endpoint.subscribe(UserAuth.pubsub_topic())

    socket =
      assign_new(socket, :current_user, fn ->
        find_current_user(session)
      end)

    case socket.assigns.current_user do
      %User{} ->
        socket

      _other ->
        socket
        |> put_flash(:error, "You must log in to access this page.")
        |> redirect(to: Routes.user_session_path(socket, :new))
    end
  end

  defp find_current_user(session) do
    with user_token when not is_nil(user_token) <- session["user_token"],
         %User{} = user <- Accounts.get_user_by_session_token(user_token),
         do: user
  end
end
