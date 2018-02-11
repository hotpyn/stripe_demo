defmodule StripeApp.Repo.Migrations.CreatePlans do
  use Ecto.Migration

  def change do
    create table(:plans, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :stripe_id, :string
      add :price, :float
      add :interval, :naive_datetime
      add :visible, :boolean, default: false, null: false

      timestamps()
    end

  end
end
