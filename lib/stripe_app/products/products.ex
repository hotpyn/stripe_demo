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

  alias StripeApp.Products.Getbook

  @doc """
  Returns the list of getbooks.

  ## Examples

      iex> list_getbooks()
      [%Getbook{}, ...]

  """
  def list_getbooks do
    Repo.all(Getbook)
  end

  @doc """
  Gets a single getbook.

  Raises `Ecto.NoResultsError` if the Getbook does not exist.

  ## Examples

      iex> get_getbook!(123)
      %Getbook{}

      iex> get_getbook!(456)
      ** (Ecto.NoResultsError)

  """
  def get_getbook!(id), do: Repo.get!(Getbook, id)

  @doc """
  Creates a getbook.

  ## Examples

      iex> create_getbook(%{field: value})
      {:ok, %Getbook{}}

      iex> create_getbook(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_getbook(attrs \\ %{}) do
    %Getbook{}
    |> Getbook.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a getbook.

  ## Examples

      iex> update_getbook(getbook, %{field: new_value})
      {:ok, %Getbook{}}

      iex> update_getbook(getbook, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_getbook(%Getbook{} = getbook, attrs) do
    getbook
    |> Getbook.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Getbook.

  ## Examples

      iex> delete_getbook(getbook)
      {:ok, %Getbook{}}

      iex> delete_getbook(getbook)
      {:error, %Ecto.Changeset{}}

  """
  def delete_getbook(%Getbook{} = getbook) do
    Repo.delete(getbook)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking getbook changes.

  ## Examples

      iex> change_getbook(getbook)
      %Ecto.Changeset{source: %Getbook{}}

  """
  def change_getbook(%Getbook{} = getbook) do
    Getbook.changeset(getbook, %{})
  end

  alias StripeApp.Products.Getplan

  @doc """
  Returns the list of getplans.

  ## Examples

      iex> list_getplans()
      [%Getplan{}, ...]

  """
  def list_getplans do
    Repo.all(Getplan)
  end

  @doc """
  Gets a single getplan.

  Raises `Ecto.NoResultsError` if the Getplan does not exist.

  ## Examples

      iex> get_getplan!(123)
      %Getplan{}

      iex> get_getplan!(456)
      ** (Ecto.NoResultsError)

  """
  def get_getplan!(id), do: Repo.get!(Getplan, id)

  @doc """
  Creates a getplan.

  ## Examples

      iex> create_getplan(%{field: value})
      {:ok, %Getplan{}}

      iex> create_getplan(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_getplan(attrs \\ %{}) do
    %Getplan{}
    |> Getplan.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a getplan.

  ## Examples

      iex> update_getplan(getplan, %{field: new_value})
      {:ok, %Getplan{}}

      iex> update_getplan(getplan, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_getplan(%Getplan{} = getplan, attrs) do
    getplan
    |> Getplan.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Getplan.

  ## Examples

      iex> delete_getplan(getplan)
      {:ok, %Getplan{}}

      iex> delete_getplan(getplan)
      {:error, %Ecto.Changeset{}}

  """
  def delete_getplan(%Getplan{} = getplan) do
    Repo.delete(getplan)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking getplan changes.

  ## Examples

      iex> change_getplan(getplan)
      %Ecto.Changeset{source: %Getplan{}}

  """
  def change_getplan(%Getplan{} = getplan) do
    Getplan.changeset(getplan, %{})
  end
end
