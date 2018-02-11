defmodule StripeAppWeb.PageController do
  use StripeAppWeb, :controller
  import Ecto.Query, warn: false

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, %{"id" => id}) do

    result = StripeApp.Repo.all (
         from p in StripeApp.Products.Getbook,
         where: [book_id: ^id, user_id: ^conn.assigns.current_user.id],
         select: p)

      case result do
        []->     redirect conn, to: book_path(conn, :show, id)
        _ -> 
    		book = StripeApp.Products.get_book!(id)
    		render(conn, "show.html", book: book)
      end
  end
end
