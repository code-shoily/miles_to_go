defmodule MilesToGo.Repo do
  use Ecto.Repo,
    otp_app: :miles_to_go,
    adapter: Ecto.Adapters.Postgres
end
