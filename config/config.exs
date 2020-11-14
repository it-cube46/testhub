# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :testhub,
  ecto_repos: [Testhub.Repo]

# Configures the endpoint
config :testhub, TesthubWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XVojkBSb1jUFbvLySXYKb2YuisDSuUrDvYc8dBp6shwXZrJxlVireQhIgrat/vUR",
  render_errors: [view: TesthubWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Testhub.PubSub,
  live_view: [signing_salt: "Tmq8cZBb"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
