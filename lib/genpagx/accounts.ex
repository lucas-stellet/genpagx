defmodule Genpagx.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false

  alias Genpagx.Accounts.User
  alias Genpagx.Repo

  @doc """
  Returns the list of users.

  ## Examples

  ```
  iex> list_users()
  [%User{}, ...]

  ```
  """
  def list_users do
    Repo.all(User)
    |> Repo.preload(:address)
  end

  def list_users(per_page, offset) do
    User
    |> paginate(per_page, offset)
    |> Repo.all()
    |> Repo.preload(:address)
  end

  defp paginate(query, per_page, offset) do
    query
    |> limit(^per_page)
    |> offset(^offset)
  end

  @doc """
  Gets a single user.

  Returns {:ok, User} if found, {:error, "User not found"} otherwise.

  ## Examples

  ```
  iex> get_user("7e664b2f-2dec-41a1-96a4-d1da7083f9ad")
  {:ok, %User{}}

  iex> get_user("invalid_id")
  {:error, "User not found"}

  ```

  """

  def get_user(id) do
    case Repo.get(User, id) do
      nil ->
        {:error, "User not found"}

      user ->
        {:ok, Repo.preload(user, :address)}
    end
  end

  @doc """
  Creates a user.

  ## Examples

  ```
  iex> create_user(%{field: value})
  {:ok, %User{}}

  iex> create_user(%{field: bad_value})
  {:error, %Ecto.Changeset{}}
  ```

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

  ```
  iex> update_user(user, %{field: new_value})
  {:ok, %User{}}

  iex> update_user(user, %{field: bad_value})
  {:error, %Ecto.Changeset{}}

  ```

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

  ```
  iex> delete_user(user)
      {:ok, %User{}}

  iex> delete_user(user)
  {:error, %Ecto.Changeset{}}
  ```

  """
  def delete_user(%User{} = user) do
    case get_user(user.id) do
      {:ok, user} ->
        Repo.delete(user)

      {:error, _} ->
        {:error, "User not found"}
    end
  end
end
