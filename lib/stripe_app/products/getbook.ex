defmodule StripeApp.Products.Getbook do
  use Ecto.Schema
  import Ecto.Changeset
  alias StripeApp.Products.Getbook


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "getbooks" do
    field :book_id, :integer
    field :price, :float
    field :stripe_charge_id, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%Getbook{} = getbook, attrs) do
    getbook
    |> cast(attrs, [:user_id, :book_id, :stripe_charge_id, :price])
    |> validate_required([:user_id, :book_id, :stripe_charge_id, :price])
  end
end
