defmodule MilesToGoWeb.Router do
  use MilesToGoWeb, :router

  import MilesToGoWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {MilesToGoWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :prelogin do
    plug :put_layout, {MilesToGoWeb.LayoutView, "single_column.html"}
  end

  scope "/", MilesToGoWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated, :prelogin]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", MilesToGoWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    delete "/users/force_logout", UserSessionController, :force_logout
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :confirm
  end

  scope "/", MilesToGoWeb do
    pipe_through [:browser, :require_authenticated_user]

    live "/", HomeLive
    live "/user/settings", UserSettingsLive
    get "/users/preferences", UserSettingsController, :edit
    put "/users/preferences", UserSettingsController, :update
    get "/users/preferences/confirm_email/:token", UserSettingsController, :confirm_email
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: MilesToGoWeb.Telemetry, ecto_repos: [MilesToGo.Repo]
      forward "/mailbox", Plug.Swoosh.MailboxPreview, base_path: "/dev/mailbox"
    end
  end
end
