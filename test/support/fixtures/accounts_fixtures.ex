defmodule MilesToGo.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MilesToGo.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "Tfgrrtd5;"

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: Faker.Person.name(),
        email: unique_user_email(),
        password: valid_user_password(),
        date_of_birth: Faker.Date.date_of_birth(18..45)
      })
      |> MilesToGo.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token, _] = String.split(captured.body, "[TOKEN]")
    token
  end
end
