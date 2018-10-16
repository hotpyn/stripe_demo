defmodule StripeApp.Products.Buyplan do
  use Ecto.Schema
  import Ecto.Changeset
  alias StripeApp.Products.Buyplan


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "buyplans" do
    field :plan_id, :binary_id
    field :user_id, :binary_id
    field :price, :float
    field :status, :integer
    field :stripe_sub_id, :string

    timestamps()
  end

  @doc false
  def changeset(%Buyplan{} = buyplan, attrs) do
    buyplan
    |> cast(attrs, [:user_id, :plan_id, :status, :stripe_sub_id, :price])
    |> validate_required([:user_id, :plan_id, :status, :stripe_sub_id, :price])
  end
end
