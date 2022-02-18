defmodule GenpagxWeb.UserControllerTest do
  @moduledoc false
  use GenpagxWeb.ConnCase

  alias Genpagx.Accounts

  setup %{conn: conn} do
    user_1 = insert(:user)
    user_2 = insert(:user)
    user_3 = insert(:user)
    address_1 = insert(:address, user_id: user_1.id)
    address_2 = insert(:address, user_id: user_2.id)
    address_3 = insert(:address, user_id: user_3.id)

    %{
      factories: %{
        user_1: user_1,
        user_2: user_2,
        user_3: user_3,
        address_1: address_1,
        address_2: address_2,
        address_3: address_3
      },
      conn: conn |> put_req_header("accept", "application/json")
    }
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      %{"data" => addresses} =
        conn
        |> get(Routes.user_path(conn, :index))
        |> json_response(200)

      assert length(addresses) == 3
    end

    test "lists all users with pagination", %{factories: %{user_2: user_2}, conn: conn} do
      assert %{"data" => [listed_user]} =
               conn
               |> get(Routes.user_path(conn, :index), limit: 1, offset: 1)
               |> json_response(200)

      assert listed_user["id"] == user_2.id
    end

    test "receives an error when pass only offset as query params", %{conn: conn} do
      assert %{"error" => %{"details" => error_details}} =
               conn
               |> get(Routes.user_path(conn, :index), offset: 1)
               |> json_response(404)

      assert error_details == "Only offset pagination parameter is not supported"
    end
  end

  describe "delete" do
    test "deletes chosen user", %{factories: %{user_1: user}, conn: conn} do
      assert "" =
               conn
               |> delete(Routes.user_path(conn, :delete, user))
               |> response(204)

      assert {:error, "User not found"} = Accounts.get_user_by_id(user.id)
    end
  end

  describe "create" do
    test "creates an account/user when pass user data and only postal code", %{conn: conn} do
      user = build(:user)
      postal_code = "78735-248"

      params = %{
        name: user.name,
        cpf: user.cpf,
        address: %{
          postal_code: postal_code
        }
      }

      assert %{"data" => account} =
               conn
               |> post(Routes.user_path(conn, :create), params)
               |> json_response(201)

      assert account["name"] == user.name
      assert account["address"]["postal_code"] == postal_code
    end

    test "receives an error message when pass user data and not found postal code", %{conn: conn} do
      user = build(:user)
      postal_code = "00000-000"

      params = %{
        name: user.name,
        cpf: user.cpf,
        address: %{
          postal_code: postal_code
        }
      }

      assert %{"error" => %{"details" => error_details}} =
               conn
               |> post(Routes.user_path(conn, :create), params)
               |> json_response(400)

      assert error_details == "Address not found by postal code, please fill manually"
    end
  end
end
