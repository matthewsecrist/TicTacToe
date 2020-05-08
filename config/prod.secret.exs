# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

config :tic_tac_toe, TicTacToeWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: "tic-tac-toe-live.herokuapp.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]]

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :tic_tac_toe, TicTacToeWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
