defmodule StripeApp.Products.Book do
  use Ecto.Schema
  import Ecto.Changeset
  alias StripeApp.Products.Book


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "books" do
    field :author, :string
    field :image, :string
    field :price, :float
    field :title, :string
    field :url, :string
    field :visible, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(%Book{} = book, attrs) do
    book
    |> cast(attrs, [:title, :author, :image, :url, :price, :visible])
    |> validate_required([:title, :author, :image, :url, :price, :visible])
  end
end
