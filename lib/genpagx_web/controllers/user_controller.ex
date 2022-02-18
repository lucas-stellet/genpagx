defmodule GenpagxWeb.UserController do
  use GenpagxWeb, :controller

  alias Genpagx.Accounts
  alias Genpagx.Addresses

  action_fallback GenpagxWeb.FallbackController

  def index(conn, params) when params == %{} do
    with users <- Accounts.list_users() do
      render(conn, "index.json", users: users)
    end
  end

  def index(conn, %{"limit" => limit, "offset" => offset}) do
    users = Accounts.list_users(limit, offset)
    render(conn, "index.json", users: users)
  end

  def index(conn, %{"offset" => _offset}) do
    conn
    |> put_status(:not_found)
    |> put_view(GenpagxWeb.ErrorView)
    |> render("error.json", reason: "Only offset pagination parameter is not supported")
  end

  def index(conn, %{"limit" => limit}) do
    users = Accounts.list_users(limit, 0)
    render(conn, "index.json", users: users)
  end

  def create(conn, params) do
    with {:ok, %{user_preloaded: user_preloaded}} <- Genpagx.create_account(params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user_preloaded)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Accounts.get_user(id) do
      render(conn, "show.json", user: user)
    end
  end

  def update(conn, %{"id" => _id}) do
    conn
    |> put_status(:bad_request)
    |> put_view(GenpagxWeb.ErrorView)
    |> render("error.json", reason: "No account values to update")
  end

  def update(conn, %{"id" => id, "name" => name, "address" => address_params}) do
    with {:ok, user} <- Accounts.get_user_by_id(id),
         {:ok, _user_updated} <- Accounts.update_user(user, %{name: name}),
         {:Ok, _address_updated} <- Addresses.update_address(user.address, address_params) do
      {:ok, user} = Accounts.get_user_by_id(id)
      render(conn, "show.json", user: user)
    end
  end

  def update(conn, %{"id" => id, "address" => address_params}) do
    with {:ok, user} <- Accounts.get_user_by_id(id),
         {:Ok, _} <- Addresses.update_address(user.address, address_params) do
      {:ok, user} = Accounts.get_user_by_id(id)
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, user} <- Accounts.get_user_by_id(id),
         {:ok, _} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
