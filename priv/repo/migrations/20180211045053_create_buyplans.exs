defmodule StripeApp.Repo.Migrations.CreateBuyplans do
  use Ecto.Migration

  def change do
    create table(:buyplans, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, :binary_id
      add :plan_id, :binary_id
      add :status, :integer
      add :stripe_sub_id, :string
      add :price, :float

      timestamps()
    end

  end
end
