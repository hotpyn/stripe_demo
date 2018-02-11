defmodule StripeApp.Repo.Migrations.CreateGetplans do
  use Ecto.Migration

  def change do
    create table(:getplans, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, :binary_id
      add :plan_id, :integer
      add :status, :integer
      add :stripe_sub_id, :string
      add :stripe_cus_id, :string
      add :price, :float

      timestamps()
    end

  end
end
