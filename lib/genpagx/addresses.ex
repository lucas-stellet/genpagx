defmodule Genpagx.Addresses do
  @moduledoc """
  The Addresses context.
  """

  import Ecto.Query, warn: false
  alias Genpagx.Repo

  alias Genpagx.Addresses.Address

  @doc """
  Returns the list of addresses.

  ## Examples

      iex> list_addresses()
      [%Address{}, ...]

  """
  def list_addresses do
    Repo.all(Address)
  end

  @doc """
  Gets a single address.

  Returns {:ok, Address} if found, {:error, "Address not found"} otherwise.

  ## Examples
  ```
  iex> get_address_by_id("7e664b2f-2dec-41a1-96a4-d1da7083f9ad)
  {:ok, %User{}}

  iex> get_address_by_id("invalid_id")
  {:error, "User not found"}
  ```

  """
  def get_address_by_id(id) do
    case Repo.get(Address, id) do
      nil -> {:error, "Address not found"}
      address -> {:ok, address}
    end
  end

  @doc """
  Creates a address.

  ## Examples

      iex> create_address(%{field: value})
      {:ok, %Address{}}

      iex> create_address(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_address(attrs) do
    %Address{}
    |> Address.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a address.

  ## Examples

      iex> update_address(address, %{field: new_value})
      {:ok, %Address{}}

      iex> update_address(address, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_address(%Address{} = address, attrs) do
    address
    |> Address.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a address.

  ## Examples

      iex> delete_address(address)
      {:ok, %Address{}}

      iex> delete_address(address)
      {:error, %Ecto.Changeset{}}

  """
  def delete_address(%Address{} = address) do
    case get_address_by_id(address.id) do
      {:ok, address} ->
        Repo.delete(address)

      {:error, _} ->
        {:error, "Address not found"}
    end
  end
end
