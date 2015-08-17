use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :josh_tetris, JoshTetris.Endpoint,
  secret_key_base: "wvmicztqGPC6mL45SN/5sTKrerjrhNE8LGS+EY9Shujhi3VYN/a7ojcYcE1zsMfp"

# Configure your database
config :josh_tetris, JoshTetris.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "josh_tetris_prod",
  size: 20 # The amount of database connections in the pool
