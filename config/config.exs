import Config

config :satanut, token: System.get_env("BOT_TOKEN")
config :satanut, stake_role_id: System.get_env("STAKE_ROLE_ID")

config :satanut,
  matches: [
    {:sardine, ["sardine", "poisson", "mer", "vitamines", "thon", "maquereau"], [], [title: "Sardina pilchardus"]},
    {:communist, ["rouge", "notre", "nous", "nos", "ensemble", "communisme", "marx", "patrie"],
     [
       "https://tenor.com/8pZh.gif",
       "https://tenor.com/3JsX.gif",
       "https://tenor.com/bG0m6.gif",
       "https://tenor.com/bAqJF.gif",
       "https://tenor.com/0PK5.gif",
       "https://tenor.com/beJMZ.gif"
     ], []},
    {:el_psy_congroo, ["chaos", "phonewave", "micro-onde"],
     [
       "https://tenor.com/view/okabe-rintaro-gif-18515625"
     ], []}
  ]
