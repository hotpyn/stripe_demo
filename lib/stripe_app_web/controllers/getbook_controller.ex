defmodule StripeAppWeb.GetbookController do

  use StripeAppWeb, :controller

  alias StripeApp.Products
  alias StripeApp.Products.Getbook
  import Ecto.Query, warn: false

  ######################################################################
  # Buy new book
  #
  # If user already purchased book, redirect to control panel
  # else buy the book
  ######################################################################

  def card(conn, %{"id" => id}) do
    book = Products.get_book!(id)
    changeset = Products.change_getbook(%Getbook{})

    result = StripeApp.Repo.all (
         from p in StripeApp.Products.Getbook,
         where: [book_id: ^id, user_id: ^conn.assigns.current_user.id],
         select: p)

      case result do
        []->    u=%{:email => conn.assigns.current_user.email }
                render(conn, "card.html", book: book, u: u, changeset: changeset)

        _ ->    redirect conn, to: page_path(conn, :show, id)
      end
  end


  ######################################################################
  # Create - new stripe customer_id or card
  # 
  # This function works, if the customer chooses to add new card
  # (i) existing customer_id --> add card, or (ii) create new user and card
  ######################################################################

  def new_card(conn, %{"stripeToken" => token, "amount" => amount, "book_id" => book_id} ) do

    {:ok, %{"id" => stripe_cus_id}} = Stripe.Customer.create(source: token, email: conn.assigns.current_user.email)
    {:ok, %{"id" => stripe_charge_id}}= Stripe.Charge.create(customer: stripe_cus_id, amount: amount, description: "book", currency: "usd")

    getbook_params=%{stripe_cus_id: stripe_cus_id, stripe_charge_id: stripe_charge_id, user_id: conn.assigns.current_user.id, book_id: book_id, price: amount}

    case Products.create_getbook(getbook_params) do
      {:ok, getbook} -> 
        IO.inspect "SUCCESS"
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect "FAILURE"
    end
    redirect conn, to: user_path(conn, :index)
  end

  ######################################################################
  # Edit - charge existing stripe customer_id
  # 
  # check for password, check card and charge
  ######################################################################

  def existing_card(conn, _params) do
  end

end

