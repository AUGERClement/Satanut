import Config

config :satanut, token: System.get_env("BOT_TOKEN")
config :satanut, stake_role_id: System.get_env("STAKE_ROLE_ID")

# config :satanut, sardines_matches: ["sardine", "poisson", "mer", "vitamines", "thon", "maquereau"]
# config :satanut, communist_matches: ["rouge", "notre", "nous", "nos", "ensemble", "communisme", "marx", "patrie"]
