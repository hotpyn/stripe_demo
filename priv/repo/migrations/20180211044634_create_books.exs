defmodule StripeApp.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :author, :string
      add :image, :string
      add :url, :string
      add :price, :float
      add :visible, :boolean, default: false, null: false

      timestamps()
    end

  end
end
