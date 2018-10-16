defmodule StripeApp.Products do
  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false
  alias StripeApp.Repo

  alias StripeApp.Products.Book

  @doc """
  Returns the list of books.

  ## Examples

      iex> list_books()
      [%Book{}, ...]

  """
  def list_books do
    Repo.all(Book)
  end

  @doc """
  Gets a single book.

  Raises `Ecto.NoResultsError` if the Book does not exist.

  ## Examples

      iex> get_book!(123)
      %Book{}

      iex> get_book!(456)
      ** (Ecto.NoResultsError)

  """
  def get_book!(id), do: Repo.get!(Book, id)

  @doc """
  Creates a book.

  ## Examples

      iex> create_book(%{field: value})
      {:ok, %Book{}}

      iex> create_book(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a book.

  ## Examples

      iex> update_book(book, %{field: new_value})
      {:ok, %Book{}}

      iex> update_book(book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Book.

  ## Examples

      iex> delete_book(book)
      {:ok, %Book{}}

      iex> delete_book(book)
      {:error, %Ecto.Changeset{}}

  """
  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book changes.

  ## Examples

      iex> change_book(book)
      %Ecto.Changeset{source: %Book{}}

  """
  def change_book(%Book{} = book) do
    Book.changeset(book, %{})
  end

  alias StripeApp.Products.Plan

  @doc """
  Returns the list of plans.

  ## Examples

      iex> list_plans()
      [%Plan{}, ...]

  """
  def list_plans do
    Repo.all(Plan)
  end

  @doc """
  Gets a single plan.

  Raises `Ecto.NoResultsError` if the Plan does not exist.

  ## Examples

      iex> get_plan!(123)
      %Plan{}

      iex> get_plan!(456)
      ** (Ecto.NoResultsError)

  """
  def get_plan!(id), do: Repo.get!(Plan, id)

  @doc """
  Creates a plan.

  ## Examples

      iex> create_plan(%{field: value})
      {:ok, %Plan{}}

      iex> create_plan(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_plan(attrs \\ %{}) do
    %Plan{}
    |> Plan.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a plan.

  ## Examples

      iex> update_plan(plan, %{field: new_value})
      {:ok, %Plan{}}

      iex> update_plan(plan, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_plan(%Plan{} = plan, attrs) do
    plan
    |> Plan.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Plan.

  ## Examples

      iex> delete_plan(plan)
      {:ok, %Plan{}}

      iex> delete_plan(plan)
      {:error, %Ecto.Changeset{}}

  """
  def delete_plan(%Plan{} = plan) do
    Repo.delete(plan)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking plan changes.

  ## Examples

      iex> change_plan(plan)
      %Ecto.Changeset{source: %Plan{}}

  """
  def change_plan(%Plan{} = plan) do
    Plan.changeset(plan, %{})
  end

  alias StripeApp.Products.Buybook

  @doc """
  Returns the list of buybooks.

  ## Examples

      iex> list_buybooks()
      [%Buybook{}, ...]

  """
  def list_buybooks do
    Repo.all(Buybook)
  end

  @doc """
  Gets a single buybook.

  Raises `Ecto.NoResultsError` if the Buybook does not exist.

  ## Examples

      iex> get_buybook!(123)
      %Buybook{}

      iex> get_buybook!(456)
      ** (Ecto.NoResultsError)

  """
  def get_buybook!(id), do: Repo.get!(Buybook, id)

  @doc """
  Creates a buybook.

  ## Examples

      iex> create_buybook(%{field: value})
      {:ok, %Buybook{}}

      iex> create_buybook(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_buybook(attrs \\ %{}) do
    %Buybook{}
    |> Buybook.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a buybook.

  ## Examples

      iex> update_buybook(buybook, %{field: new_value})
      {:ok, %Buybook{}}

      iex> update_buybook(buybook, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_buybook(%Buybook{} = buybook, attrs) do
    buybook
    |> Buybook.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Buybook.

  ## Examples

      iex> delete_buybook(buybook)
      {:ok, %Buybook{}}

      iex> delete_buybook(buybook)
      {:error, %Ecto.Changeset{}}

  """
  def delete_buybook(%Buybook{} = buybook) do
    Repo.delete(buybook)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking buybook changes.

  ## Examples

      iex> change_buybook(buybook)
      %Ecto.Changeset{source: %Buybook{}}

  """
  def change_buybook(%Buybook{} = buybook) do
    Buybook.changeset(buybook, %{})
  end

  alias StripeApp.Products.Buyplan

  @doc """
  Returns the list of buyplans.

  ## Examples

      iex> list_buyplans()
      [%Buyplan{}, ...]

  """
  def list_buyplans do
    Repo.all(Buyplan)
  end

  @doc """
  Gets a single buyplan.

  Raises `Ecto.NoResultsError` if the Buyplan does not exist.

  ## Examples

      iex> get_buyplan!(123)
      %Buyplan{}

      iex> get_buyplan!(456)
      ** (Ecto.NoResultsError)

  """
  def get_buyplan!(id), do: Repo.get!(Buyplan, id)

  @doc """
  Creates a buyplan.

  ## Examples

      iex> create_buyplan(%{field: value})
      {:ok, %Buyplan{}}

      iex> create_buyplan(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_buyplan(attrs \\ %{}) do
    %Buyplan{}
    |> Buyplan.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a buyplan.

  ## Examples

      iex> update_buyplan(buyplan, %{field: new_value})
      {:ok, %Buyplan{}}

      iex> update_buyplan(buyplan, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_buyplan(%Buyplan{} = buyplan, attrs) do
    buyplan
    |> Buyplan.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Buyplan.

  ## Examples

      iex> delete_buyplan(buyplan)
      {:ok, %Buyplan{}}

      iex> delete_buyplan(buyplan)
      {:error, %Ecto.Changeset{}}

  """
  def delete_buyplan(%Buyplan{} = buyplan) do
    Repo.delete(buyplan)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking buyplan changes.

  ## Examples

      iex> change_buyplan(buyplan)
      %Ecto.Changeset{source: %Buyplan{}}

  """
  def change_buyplan(%Buyplan{} = buyplan) do
    Buyplan.changeset(buyplan, %{})
  end
end
