defmodule StripeApp.Products.Buybook do
  use Ecto.Schema
  import Ecto.Changeset
  alias StripeApp.Products.Buybook


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "buybooks" do
    field :book_id, :binary_id
    field :user_id, :binary_id
    field :price, :float
    field :stripe_charge_id, :string

    timestamps()
  end

  @doc false
  def changeset(%Buybook{} = buybook, attrs) do
    buybook
    |> cast(attrs, [:user_id, :book_id, :stripe_charge_id, :price])
    |> validate_required([:user_id, :book_id, :stripe_charge_id, :price])
  end
end
