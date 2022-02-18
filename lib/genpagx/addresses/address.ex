defmodule Genpagx.Addresses.Address do
  @moduledoc """
  Address schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Genpagx.Services.ViaCEP

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @states ~w( AC AL AP AM BA CE DF ES GO MA MT MS MG PA PB PR PE PI RJ RN RS RO RR SC SP SE TO )a

  schema "addresses" do
    field :street, :string
    field :city, :string
    field :complement, :string, null: true
    field :neighborhood, :string
    field :number, :integer, null: true
    field :postal_code, :string
    field :state, Ecto.Enum, values: @states

    belongs_to :user, Genpagx.Accounts.User

    timestamps()
  end

  @cast_fields ~w( street city complement neighborhood number postal_code user_id state )a
  @required_fields ~w( street city neighborhood postal_code state )a
  @doc false
  def changeset(address \\ %__MODULE__{}, attrs) do
    address
    |> cast(attrs, @cast_fields)
    |> change_by_via_cep(attrs)
    |> validate_required(@required_fields)
  end

  defp change_by_via_cep(changeset, %{"postal_code" => postal_code}) do
    case ViaCEP.validate_cep(postal_code) do
      {:ok, address} ->
        changes = %{
          street: address.logradouro,
          city: address.localidade,
          neighborhood: address.bairro,
          state: String.to_existing_atom(address.uf)
        }

        change(changeset, changes)

      {:error, _error} ->
        changeset
    end
  end
end
