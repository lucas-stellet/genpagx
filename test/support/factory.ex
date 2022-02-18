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

  def address_factory do
    %Address{
      street: FakerAddressBR.street_name(),
      city: FakerAddressBR.city(),
      neighborhood: FakerAddressBR.neighborhood(),
      state: FakerAddressBR.state()
    }
  end
end
