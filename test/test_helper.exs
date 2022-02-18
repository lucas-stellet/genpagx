ExUnit.start()

# Faker start
Faker.start()

# ex_machina start
{:ok, _} = Application.ensure_all_started(:ex_machina)

Ecto.Adapters.SQL.Sandbox.mode(Genpagx.Repo, :manual)
