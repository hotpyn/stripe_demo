defmodule StripeApp.Repo.Migrations.CreateGetbooks do
  use Ecto.Migration

  def change do
    create table(:getbooks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, :binary_id
      add :book_id, :integer
      add :stripe_charge_id, :string
      add :stripe_cus_id, :string
      add :price, :float

      timestamps()
    end

  end
end
