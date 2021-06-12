# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :miles_to_go,
  ecto_repos: [MilesToGo.Repo]

# Configures the endpoint
config :miles_to_go, MilesToGoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Geyd/la4rFamR87kNCr8XgKQVqeB0wNsk6xUgOe31/IGH5L8FiJ6m4bveC9Mn/Cv",
  render_errors: [view: MilesToGoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: MilesToGo.PubSub,
  live_view: [signing_salt: "1qveQIHZ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
