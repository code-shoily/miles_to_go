defmodule MilesToGoWeb.UserSessionController do
  use MilesToGoWeb, :controller

  alias MilesToGo.Accounts
  alias MilesToGoWeb.UserAuth

  def new(conn, _params) do
    render(conn, "new.html", error_message: nil)
  end

  def create(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password} = user_params

    if user = Accounts.get_user_by_email_and_password(email, password) do
      UserAuth.log_in_user(conn, user, user_params)
    else
      render(conn, "new.html", error_message: "Invalid email or password")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end

  def force_logout(conn, _params) do
    conn
    |> put_flash(
      :info,
      "You were logged out from all sessions. Please login again."
    )
    |> UserAuth.log_out_user(true)
  end
end
