# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :user_api, UserApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mMybC0hpVQc3vPh+l+MiEhltF86qlRWzYK/5suz8dul8qagXUquhfmG2ILr6M/TT",
  render_errors: [view: UserApiWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: UserApi.PubSub,
  live_view: [signing_salt: "w6Wp9DAC"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
