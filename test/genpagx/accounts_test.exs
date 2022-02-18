defmodule Genpagx.AccountsTest do
  @moduledoc false
  use Genpagx.DataCase

  alias Genpagx.Accounts
  alias Faker.Person.PtBr, as: FakerPersonBR

  describe "create_user/1" do
    test "creates an user when the given parameters are valid" do
      user_params = %{
        name: FakerPersonBR.name(),
        cpf: Faker.Util.format("%3d.%3d.%3d-%2d")
      }

      assert {:ok, user} = Accounts.create_user(user_params)

      assert user.name == user_params.name
    end

    test "returns an error when the given parameters are invalid" do
      user_params = %{
        name: FakerPersonBR.name()
      }

      assert {:error, %Ecto.Changeset{errors: [cpf: {error, _}]}} =
               Accounts.create_user(user_params)

      assert error == "can't be blank"
    end
  end

  describe "list_user/1" do
    test "returns a list of users" do
      for _ <- 1..3 do
        insert(:user)
      end

      assert users = Accounts.list_users()

      assert length(users) == 3
    end

    test "returns a empty list when there is no user inserted" do
      assert [] = Accounts.list_users()
    end
  end

  describe "list_user/2" do
    test "returns a a list of 3 users starting from the 3" do
      insert(:user)
      insert(:user)
      insert(:user)
      user_4 = insert(:user)
      user_5 = insert(:user)
      user_6 = insert(:user)

      per_page = 3
      offset = 3

      assert [inserted_user_4, inserted_user_5, inserted_user_6] =
               Accounts.list_users(per_page, offset)

      assert inserted_user_4.name == user_4.name
      assert inserted_user_5.name == user_5.name
      assert inserted_user_6.name == user_6.name
    end
  end

  describe "get_user/1" do
    test "returns an user" do
      user = insert(:user)

      assert {:ok, inserted_user} = Accounts.get_user(user.id)

      assert inserted_user.id == user.id
    end

    test "returns an error tuple when the user is not inserted" do
      assert {:error, "User not found"} = Accounts.get_user(Ecto.UUID.generate())
    end
  end

  describe "update_user/2" do
    test "updates user's name" do
      user = insert(:user)

      new_name = FakerPersonBR.name()

      assert {:ok, updated_user} = Accounts.update_user(user, %{name: new_name})

      assert updated_user.name == new_name
    end

    test "returns an unchanged user when try to update the user's cpf" do
      user = insert(:user)

      new_cpf = "000.000.000-00"

      assert {:ok, unchanged_user} = Accounts.update_user(user, %{cpf: new_cpf})

      assert unchanged_user.cpf == user.cpf
    end
  end

  describe "delete_user/1" do
    test "delete a inserted user" do
      user = insert(:user)

      assert {:ok, deleted_user} = Accounts.delete_user(user)

      assert deleted_user.id == user.id
    end

    test "returns an error tuple when try to delete an deleted user" do
      user = insert(:user)
      Accounts.delete_user(user)

      assert {:error, "User not found"} = Accounts.delete_user(user)
    end
  end
end
