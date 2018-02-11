defmodule StripeAppWeb.GetbookController do
  use StripeAppWeb, :controller

  alias StripeApp.Products
  alias StripeApp.Products.Getbook

  def index(conn, _params) do
    getbooks = Products.list_getbooks()
    render(conn, "index.html", getbooks: getbooks)
  end

  def new(conn, _params) do
    changeset = Products.change_getbook(%Getbook{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"getbook" => getbook_params}) do
    case Products.create_getbook(getbook_params) do
      {:ok, getbook} ->
        conn
        |> put_flash(:info, "Getbook created successfully.")
        |> redirect(to: getbook_path(conn, :show, getbook))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    getbook = Products.get_getbook!(id)
    render(conn, "show.html", getbook: getbook)
  end

  def edit(conn, %{"id" => id}) do
    getbook = Products.get_getbook!(id)
    changeset = Products.change_getbook(getbook)
    render(conn, "edit.html", getbook: getbook, changeset: changeset)
  end

  def update(conn, %{"id" => id, "getbook" => getbook_params}) do
    getbook = Products.get_getbook!(id)

    case Products.update_getbook(getbook, getbook_params) do
      {:ok, getbook} ->
        conn
        |> put_flash(:info, "Getbook updated successfully.")
        |> redirect(to: getbook_path(conn, :show, getbook))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", getbook: getbook, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    getbook = Products.get_getbook!(id)
    {:ok, _getbook} = Products.delete_getbook(getbook)

    conn
    |> put_flash(:info, "Getbook deleted successfully.")
    |> redirect(to: getbook_path(conn, :index))
  end
end
