defmodule Genpagx.Accounts.User do
  @moduledoc """
  User schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field :cpf, :string
    field :name, :string

    has_one :address, Genpagx.Addresses.Address

    timestamps()
  end

  @registrations_fields ~w( cpf name )a
  @doc false
  def changeset(user \\ %__MODULE__{}, attrs) do
    user
    |> cast(attrs, @registrations_fields)
    |> validate_name()
    |> validate_cpf()
  end

  defp validate_cpf(changeset) do
    changeset
    |> validate_required([:cpf])
    |> validate_format(:cpf, ~r/^\d{3}\.\d{3}\.\d{3}\-\d{2}$/, message: "has invalid format")
    |> unique_constraint(:cpf, name: :index_users_cpf, message: "already registered")
  end

  defp validate_name(changeset) do
    changeset
    |> validate_required([:name])
    |> validate_length(:name, min: 4, max: 160)
  end

  @update_fields ~w( name )a
  @doc false
  def update_changeset(user, attrs) do
    user
    |> cast(attrs, @update_fields)
    |> validate_name()
  end
end
