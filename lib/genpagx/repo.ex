defmodule Genpagx.Repo do
  use Ecto.Repo,
    otp_app: :genpagx,
    adapter: Ecto.Adapters.Postgres
end
