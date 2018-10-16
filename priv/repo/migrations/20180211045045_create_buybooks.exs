defmodule StripeApp.Repo.Migrations.CreateBuybooks do
  use Ecto.Migration

  def change do
    create table(:buybooks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, :binary_id
      add :book_id, :binary_id
      add :stripe_charge_id, :string
      add :price, :float

      timestamps()
    end

  end
end
