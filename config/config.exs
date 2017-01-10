# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :suggestotron,
  ecto_repos: [Suggestotron.Repo]

# Configures the endpoint
config :suggestotron, Suggestotron.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BCWg6W2lBcHx0+0wiePnrP7e8UVuglamZStkuXo6KpjpJYNfgPcepAiAE2T1LYVr",
  render_errors: [view: Suggestotron.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Suggestotron.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :addict,
  secret_key: "243262243132244579666b67312f794f424358415a4662555553787465",
  extra_validation: fn ({valid, errors}, user_params) -> {valid, errors} end, # define extra validation here
  user_schema: Suggestotron.User,
  repo: Suggestotron.Repo,
  from_email: "no-reply@example.com", # CHANGE THIS
mail_service: nil