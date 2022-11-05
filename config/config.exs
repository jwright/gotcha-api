import Config

config :gotcha,
  ecto_repos: [Gotcha.Repo]

# Configures the endpoint
config :gotcha, GotchaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0TqZihHm9fomzyU5neLa60HyR6nBfLZp0ZRROI5IJjX912r36rupk94qqHNIdcLY",
  render_errors: [view: GotchaWeb.ErrorView, accepts: ~w(json)],
  pubsub_server: Gotcha.PubSub

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :joken, default_signer: "wFR1FA0jF1CKJ2+Md3RI4HLffep5PtUJm9vZfu+Pba9lqPz0yHLwHfzbrmgJwyKT"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
