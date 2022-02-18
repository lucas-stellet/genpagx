defmodule Genpagx do
  @moduledoc """
  Genpagx keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Ecto.Multi
  alias Genpagx.{Accounts, Addresses}
  alias Genpagx.Repo
  alias Genpagx.Services.ViaCEP

  def create_account(%{"name" => name, "cpf" => cpf, "address" => address}) do
    Multi.new()
    |> Multi.run(:postal_code_search, fn _, _ ->
      case ViaCEP.validate_cep(address["postal_code"]) do
        {:ok, _} ->
          {:ok, ""}

        {:error, "Invalid postal code format" = message} ->
          {:error, message}

        {:error, _} ->
          {:error, "Address not found by postal code, please fill manually"}
      end
    end)
    |> Multi.run(:user, fn _, _ ->
      Accounts.create_user(%{name: name, cpf: cpf})
    end)
    |> Multi.run(:address, fn _, %{user: user} ->
      Addresses.create_address(Map.put(address, "user_id", user.id))
    end)
    |> Multi.run(:user_preloaded, fn _, %{user: user} ->
      user = Repo.preload(user, :address)
      {:ok, user}
    end)
    |> Repo.transaction()
  end
end
