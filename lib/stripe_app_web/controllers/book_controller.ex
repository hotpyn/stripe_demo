defmodule StripeAppWeb.BookController do
  use StripeAppWeb, :controller
  import Ecto.Query, warn: false

  alias StripeApp.Products
  alias StripeApp.Products.Book

  def index(conn, _params) do
    books = Products.list_books()
    render(conn, "index.html", books: books)
  end

  def show(conn, %{"id" => id}) do
    book = Products.get_book!(id)
    render(conn, "show.html", book: book)
  end

  def read(conn, %{"id" => id}) do

    result1 = StripeApp.Repo.all (
         from p in StripeApp.Products.Getbook,
         where: [book_id: ^id, user_id: ^conn.assigns.current_user.id],
         select: p)

    result2 = StripeApp.Repo.all (
         from p in StripeApp.Products.Getplan,
         where: [user_id: ^conn.assigns.current_user.id],
         select: p)
	IO.inspect result1
	IO.inspect result2

      case [result1,result2] do
        [[],[]]->     redirect conn, to: book_path(conn, :show, id)
        _ ->
                book = StripeApp.Products.get_book!(id)
                render(conn, "read.html", book: book)
      end
  end

end
