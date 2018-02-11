# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :stripe_app,
  ecto_repos: [StripeApp.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :stripe_app, StripeAppWeb.Endpoint,
  url: [host: System.get_env("DOMAIN"), port: System.get_env("PORT")],
  secret_key_base: "5/uvDSgp4hmTvBNGyr7jC3NNx+7xm7+9qGugp5DbqDvihNY+e+73kZe/A15l9MoK",
  render_errors: [view: StripeAppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: StripeApp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Stripe
config :stripe, :secret_key, System.get_env("STRIPE_SECRET_KEY")

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: StripeApp.Coherence.User,
  repo: StripeApp.Repo,
  module: StripeApp,
  web_module: StripeAppWeb,
  router: StripeAppWeb.Router,
  messages_backend: StripeAppWeb.Coherence.Messages,
  require_current_password: false,
  logged_out_url: "/",
  allow_unconfirmed_access_for: 5,
  user_active_field: true,
  email_from_name: System.get_env("DOMAIN"),
  email_from_email: System.get_env("SMTP_USERNAME"),
  opts: [:rememberable, :unlockable_with_token, :invitable, :recoverable, :lockable, :trackable, :confirmable, :registerable, :authenticatable]

config :coherence, StripeAppWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Mailgun,
  api_key: System.get_env("MAILGUN_KEY"),
  domain: System.get_env("DOMAIN")
# %% End Coherence Configuration %%


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
