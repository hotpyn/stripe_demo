defmodule StripeApp.Products.Getplan do
  use Ecto.Schema
  import Ecto.Changeset
  alias StripeApp.Products.Getplan


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "getplans" do
    field :plan_id, :integer
    field :price, :float
    field :status, :integer
    field :stripe_sub_id, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%Getplan{} = getplan, attrs) do
    getplan
    |> cast(attrs, [:user_id, :plan_id, :status, :stripe_sub_id, :price])
    |> validate_required([:user_id, :plan_id, :status, :stripe_sub_id, :price])
  end
end
