defmodule Genpagx.AddressesTest do
  @moduledoc false
  use Genpagx.DataCase

  alias Genpagx.Addresses

  setup do
    %{user: insert(:user)}
  end

  describe "list_addresses/0" do
    test "returns all addresses" do
      insert(:address)
      insert(:address)
      insert(:address)

      assert addresses = Addresses.list_addresses()

      assert length(addresses) == 3
    end
  end

  describe "get_address_by_id/1" do
    setup %{user: user} do
      address = insert(:address, user_id: user.id)

      %{address: address}
    end

    test "returns the address with given id", %{address: address} do
      assert {:ok, inserted_address} = Addresses.get_address_by_id(address.id)
      assert(inserted_address.id == address.id)
    end

    test "returns an error tuple with given invalid id" do
      assert {:error, "Address not found"} = Addresses.get_address_by_id(Ecto.UUID.generate())
    end
  end

  describe "create_address/1" do
    test "returns an address when pass valid params", %{user: user} do
      address_params = %{
        "street" => "street",
        "city" => "city",
        "state" => :RJ,
        "postal_code" => "00000-000",
        "neighborhood" => "neighborhood",
        "user_id" => user.id
      }

      assert {:ok, inserted_address} = Addresses.create_address(address_params)

      assert inserted_address.street == "street"
      assert inserted_address.city == "city"
    end

    test "returns an error when pass invalid zip code and not given the remaining params" do
      address_params = %{
        "postal_code" => "00000-000",
        "state" => :PE
      }

      assert {:error, %Ecto.Changeset{}} = Addresses.create_address(address_params)
    end
  end

  describe "update_address/2" do
    test "returns an address updated when pass valid params", %{user: user} do
      address = insert(:address, user_id: user.id)

      assert {:ok, updated_address} =
               Addresses.update_address(address, %{"postal_code" => "00000-000"})

      assert updated_address.postal_code == "00000-000"
    end
  end

  describe "delete_address/1" do
    test "returns an address when pass valid params", %{user: user} do
      address = insert(:address, user_id: user.id)

      assert {:ok, _delete_address} = Addresses.delete_address(address)
    end
  end
end
