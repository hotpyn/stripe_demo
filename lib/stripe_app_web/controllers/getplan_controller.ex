defmodule StripeAppWeb.GetplanController do
  use StripeAppWeb, :controller

  alias StripeApp.Products
  alias StripeApp.Products.Getplan

  def index(conn, _params) do
    getplans = Products.list_getplans()
    render(conn, "index.html", getplans: getplans)
  end

  def new(conn, _params) do
    changeset = Products.change_getplan(%Getplan{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"getplan" => getplan_params}) do
    case Products.create_getplan(getplan_params) do
      {:ok, getplan} ->
        conn
        |> put_flash(:info, "Getplan created successfully.")
        |> redirect(to: getplan_path(conn, :show, getplan))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    getplan = Products.get_getplan!(id)
    render(conn, "show.html", getplan: getplan)
  end

  def edit(conn, %{"id" => id}) do
    getplan = Products.get_getplan!(id)
    changeset = Products.change_getplan(getplan)
    render(conn, "edit.html", getplan: getplan, changeset: changeset)
  end

  def update(conn, %{"id" => id, "getplan" => getplan_params}) do
    getplan = Products.get_getplan!(id)

    case Products.update_getplan(getplan, getplan_params) do
      {:ok, getplan} ->
        conn
        |> put_flash(:info, "Getplan updated successfully.")
        |> redirect(to: getplan_path(conn, :show, getplan))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", getplan: getplan, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    getplan = Products.get_getplan!(id)
    {:ok, _getplan} = Products.delete_getplan(getplan)

    conn
    |> put_flash(:info, "Getplan deleted successfully.")
    |> redirect(to: getplan_path(conn, :index))
  end
end
