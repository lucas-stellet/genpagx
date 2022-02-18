# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Genpagx.Repo.insert!(%Genpagx.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Genpagx.Accounts
alias Genpagx.Addresses

users = [
  %{
    "name" => "Murilo José Fernandes",
    "cpf" => "156.402.961-19"
  },
  %{
    "name" => "Lorena Luciana Allana Almada",
    "cpf" => "924.371.588-71"
  },
  %{
    "name" => "Eliane Alana Isabelle Campos",
    "cpf" => "321.268.294-99"
  },
  %{
    "name" => "Sophia Eduarda Mendes",
    "cpf" => "347.130.681-10"
  },
  %{
    "name" => "Jorge Carlos Mário Assis",
    "cpf" => "016.434.287-72"
  },
  %{
    "name" => "Rodrigo Giovanni Gomes",
    "cpf" => "221.294.250-89"
  }
]

ceps = [
  %{
    "street" => "Rua João Pessoa",
    "city" => "João Pessoa",
    "neighborhood" => "Centro",
    "state" => "PB",
    "number" => "100",
    "postal_code" => "58020-000"
  },
  %{
    "street" => "Rua da Penha",
    "city" => "Campo Grande",
    "neighborhood" => "Santa Rosa",
    "state" => "MT",
    "number" => "301",
    "postal_code" => "78040-210"
  },
  %{
    "street" => "Rua Falcão",
    "city" => "Olinda",
    "neighborhood" => "Ouro Preto",
    "state" => "PE",
    "number" => "82",
    "postal_code" => "53370-101"
  },
  %{
    "street" => "Quadra SQNW 109 Bloco D",
    "city" => "Brasilia",
    "neighborhood" => "Setor Noroeste",
    "state" => "DF",
    "number" => "12",
    "postal_code" => "70686-420"
  },
  %{
    "street" => "Rua da Penha",
    "city" => "Campos dos Goitacazes",
    "neighborhood" => "Parque Rosario",
    "state" => "RJ",
    "number" => "651",
    "postal_code" => "28027-450"
  }
]

for n <- 1..4 do
  {:ok, user} = Accounts.create_user(Enum.at(users, n))
  address = Enum.at(ceps, n)
  address_with_user = Map.put(address, "user_id", user.id)
  Addresses.create_address(address_with_user)
end
