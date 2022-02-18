defmodule Genpagx.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: Genpagx.Repo
  alias Genpagx.Accounts.User
  alias Genpagx.Addresses.Address

  alias Faker.Address.PtBr, as: FakerAddressBR
  alias Faker.Person.PtBr, as: FakerPersonBR

  def user_factory do
    %User{
      name: FakerPersonBR.name(),
      cpf: Faker.Util.format("%3d.%3d.%3d-%2d")
    }
  end

  @states ~w( AC AL AP AM BA CE DF ES GO MA MT MS MG PA PB PR PE PI RJ RN RS RO RR SC SP SE TO )a

  def address_factory do
    %Address{
      street: FakerAddressBR.street_name(),
      city: FakerAddressBR.city(),
      neighborhood: FakerAddressBR.neighborhood(),
      state: Enum.random(@states),
      postal_code: Faker.Util.format("%5d-%3d")
    }
  end
end
