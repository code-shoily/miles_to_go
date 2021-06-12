defmodule MilesToGoWeb.UserRegistrationControllerTest do
  use MilesToGoWeb.ConnCase, async: true

  import MilesToGo.AccountsFixtures

  describe "GET /users/register" do
    test "renders registration page", %{conn: conn} do
      conn = get(conn, Routes.user_registration_path(conn, :new))
      response = html_response(conn, 200)

      assert response =~
               ~s{<div class="title is-3 has-text-primary has-text-centered">Register</div>}

      assert response =~ "Log in</a>"
      assert response =~ "password?</a>"
    end

    test "redirects if already logged in", %{conn: conn} do
      conn = conn |> log_in_user(user_fixture()) |> get(Routes.user_registration_path(conn, :new))
      assert redirected_to(conn) == "/"
    end
  end

  describe "POST /users/register" do
    @tag :capture_log
    test "creates account and logs the user in", %{conn: conn} do
      email = unique_user_email()

      conn =
        post(conn, Routes.user_registration_path(conn, :create), %{
          "user" => %{
            "name" => Faker.Person.name(),
            "email" => email,
            "password" => valid_user_password(),
            "date_of_birth" => Faker.Date.date_of_birth()
          }
        })

      assert get_session(conn, :user_token)
      assert redirected_to(conn) =~ "/"

      # Now do a logged in request and assert on the menu
      conn = get(conn, "/")
      response = html_response(conn, 200)
      assert response =~ email
      assert response =~ "Settings</a>"
      assert response =~ "Log out</a>"
    end

    test "render errors for invalid data", %{conn: conn} do
      conn =
        post(conn, Routes.user_registration_path(conn, :create), %{
          "user" => %{
            "name" => "Mafinar Khan",
            "email" => "with spaces",
            "password" => "too short"
          }
        })

      response = html_response(conn, 200)

      assert response =~
               ~s{<div class="title is-3 has-text-primary has-text-centered">Register</div>}

      assert response =~ "must have the @ sign and no spaces"
      assert response =~ "at least one digit or punctuation"
    end
  end
end
