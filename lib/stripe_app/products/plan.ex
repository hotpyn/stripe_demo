defmodule StripeApp.Products.Plan do
  use Ecto.Schema
  import Ecto.Changeset
  alias StripeApp.Products.Plan


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "plans" do
    field :interval, :naive_datetime
    field :name, :string
    field :price, :float
    field :stripe_id, :string
    field :visible, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(%Plan{} = plan, attrs) do
    plan
    |> cast(attrs, [:name, :stripe_id, :price, :interval, :visible])
    |> validate_required([:name, :stripe_id, :price, :interval, :visible])
  end
end
