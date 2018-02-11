defmodule StripeAppWeb.BookController do
  use StripeAppWeb, :controller

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

end
