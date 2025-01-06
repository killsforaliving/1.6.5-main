# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

### Database: DATABASE_URL / POOL_SIZE ###
database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :spades, Spades.Repo,
  # ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

### SECRET_KEY_BASE ###
secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :spades, SpadesWeb.Endpoint,
  http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: secret_key_base

### Mail: MAILGUN_API_KEY / MAILGUN_DOMAIN###
mailgun_api_key =
  System.get_env("MAILGUN_API_KEY") ||
    raise """
    environment variable MAILGUN_API_KEY is missing.
    """

mailgun_domain =
  System.get_env("MAILGUN_DOMAIN") ||
    raise """
    environment variable MAILGUN_DOMAIN is missing.
    """

config :spades, Spades.Mailer,
  adapter: Swoosh.Adapters.Mailgun,
  api_key: mailgun_api_key,
  domain: mailgun_domain

config :spades, SpadesWeb.PowMailer,
  adapter: Swoosh.Adapters.Mailgun,
  api_key: mailgun_api_key,
  domain: mailgun_domain

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
config :spades, SpadesWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
