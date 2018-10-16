defmodule StripeAppWeb.BuyplanController do

  use StripeAppWeb, :controller

  alias StripeApp.Products
  alias StripeApp.Products.Buyplan
  import Ecto.Query, warn: false

  ######################################################################
  #
  #	This function checks whether the user already bought the book.
  #
  ######################################################################

  def buyplan(conn, %{"id" => id}) do
    plan = Products.get_plan!(id)
    changeset = Products.change_getplan(%Buyplan{})

    result = StripeApp.Repo.all (
         from p in StripeApp.Products.Buyplan,
         where: [plan_id: ^id, user_id: ^conn.assigns.current_user.id],
         select: p)

      case result do
        []->    u=%{:email => conn.assigns.current_user.email }
                render(conn, "buyplan.html", plan: plan, u: u, changeset: changeset)

        _ ->    redirect conn, to: book_path(conn, :index)
      end
  end


  ######################################################################
  #
  #	Subscribe plan, when the user wants to use new card.
  #
  ######################################################################

  def new_card(conn, %{"plan_id" => plan_id, "amount" => amount, "stripeToken" => token} ) do
    {:ok, %{"id" => stripe_cus_id}} = Stripe.Customer.create(source: token, email: conn.assigns.current_user.email)
    {:ok, %{"id" => stripe_sub_id}} = Stripe.Subscription.create(customer: stripe_cus_id, plan: "Tutorial")

    getplan_params=%{stripe_cus_id: stripe_cus_id, stripe_sub_id: stripe_sub_id, user_id: conn.assigns.current_user.id, plan_id: plan_id, price: amount, status: 1}

    case Products.create_getplan(getplan_params) do
      {:ok, getplan} ->
        IO.inspect "SUCCESS"
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect "FAILURE"
    end

    redirect conn, to: book_path(conn, :index)
  end
  ######################################################################
  #
  # existing stripe_id, new card
  #
  ######################################################################
  def existing_user(conn, %{"plan_id" => plan_id, "amount" => amount, "stripeToken" => token} ) do
    {:ok, %{"id" => stripe_cus_id}} = Stripe.Customer.create(source: token, email: conn.assigns.current_user.email)
    {:ok, %{"id" => stripe_sub_id}} = Stripe.Subscription.create(customer: stripe_cus_id, plan: "Tutorial")

    getplan_params=%{stripe_cus_id: stripe_cus_id, stripe_sub_id: stripe_sub_id, user_id: conn.assigns.current_user.id, plan_id: plan_id, price: amount, status: 1}

    case Products.create_getplan(getplan_params) do
      {:ok, getplan} ->
        IO.inspect "SUCCESS"
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect "FAILURE"
    end

    redirect conn, to: book_path(conn, :index)
  end



  ######################################################################
  #
  # Existing stripe_id, existing card
  #
  ######################################################################
  def existing_card(conn, %{"plan_id" => plan_id, "amount" => amount, "stripeToken" => token} ) do
    {:ok, %{"id" => stripe_cus_id}} = Stripe.Customer.create(source: token, email: conn.assigns.current_user.email)
    {:ok, %{"id" => stripe_sub_id}} = Stripe.Subscription.create(customer: stripe_cus_id, plan: "Tutorial")

    getplan_params=%{stripe_cus_id: stripe_cus_id, stripe_sub_id: stripe_sub_id, user_id: conn.assigns.current_user.id, plan_id: plan_id, price: amount, status: 1}

    case Products.create_getplan(getplan_params) do
      {:ok, getplan} ->
        IO.inspect "SUCCESS"
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect "FAILURE"
    end

    redirect conn, to: book_path(conn, :index)
  end


  ######################################################################
  #
  #	checks whether user is sure about canceling
  #
  ######################################################################

  def cancel(conn, %{"id" => id}) do
    render(conn, "cancel.html", %{id: id})
  end

  ######################################################################
  #
  #	cancels plan
  #
  ######################################################################

  def cancel_sure(conn, %{"id" => id}) do

    results = StripeApp.Repo.all (
         from p in StripeApp.Products.Buyplan,
         where: [user_id: ^conn.assigns.current_user.id],
         select: p)

    ##### delete plan at Stripe #####

    [%{stripe_sub_id: stripe_sub_id}]=Enum.map(results, &Map.take(&1, [:stripe_sub_id]))
    Stripe.Subscription.delete(stripe_sub_id)

    ##### delete local database #####

    StripeApp.Repo.delete_all (
         from p in StripeApp.Products.Buyplan,
         where: [user_id: ^conn.assigns.current_user.id])

    redirect conn, to: user_path(conn, :index)

  end

end
