defmodule Genpagx.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :street, :string
      add :number, :integer
      add :complement, :string, null: true
      add :neighborhood, :string
      add :city, :string
      add :state, :string
      add :postal_code, :string
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:addresses, [:user_id])
  end
end
