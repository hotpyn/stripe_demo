defmodule StripeAppWeb.GetplanController do

  use StripeAppWeb, :controller

  alias StripeApp.Products
  alias StripeApp.Products.Getplan

  ######################################################################
  #
  # subscribe to new plan
  #
  # Server-monthly                  Server-monthly                  N
  # Server-yearly                   Server-monthly                  D
  # Book-monthly                    Server-monthly                  U
  # Book-yearly                     Server-monthly                  D
  # Server-monthly                  Server-yearly                   U
  # Server-yearly                   Server-yearly                   N
  # Book-monthly                    Server-yearly                   U
  # Book-yearly                     Server-yearly                   U
  # Server-monthly                  Book-monthly                    D
  # Server-yearly                   Book-monthly                    D
  # Book-monthly                    Book-monthly                    N
  # Book-yearly                     Book-monthly                    D
  # Server-monthly                  Book-yearly                     U
  # Server-yearly                   Book-yearly                     D
  # Book-monthly                    Book-yearly                     U
  # Book-yearly                     Book-yearly                     N
  #
  ######################################################################

  ######################################################################
  #
  #	Order new plan, upgrade plan, downgrade plan.
  #	This function will create forms for user to take action.
  #
  ######################################################################

  def card(conn, %{"id" => id}) do
    plan = Products.get_plan!(id)
    changeset = Products.change_getplan(%Getplan{})
    u=%{:email => conn.assigns.current_user.email }
    render(conn, "card.html", plan: plan, u: u, changeset: changeset)
  end


  ######################################################################
  #
  #	Subscribe plan, when the user does not have existing
  #	stripe_id or does not want to use existing card
  #
  ######################################################################

  def new_card(conn, %{"plan_id" => id, "amount" => amount, "stripeToken" => token} ) do
    {:ok, %{"id" => stripe_cus_id}} = Stripe.Customer.create(source: token, email: conn.assigns.current_user.email)
    {:ok, %{"id" => stripe_sub_id}} = Stripe.Subscription.create(customer: stripe_cus_id, plan: "Tutorial")

    getplan_params=%{stripe_cus_id: stripe_cus_id, stripe_sub_id: stripe_sub_id, user_id: conn.assigns.current_user.id, plan_id: 1, price: amount, status: 1}

    case Products.create_getplan(getplan_params) do
      {:ok, getplan} ->
        IO.inspect "SUCCESS"
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect "FAILURE"
    end

    redirect conn, to: user_path(conn, :index)
  end


  ######################################################################
  #
  # Subscription, if the user wants to use existing card/stripe_id
  #
  ######################################################################

  def existing_card do
  end


  ######################################################################
  #
  #	Cancel plans
  #
  ######################################################################

  def cancel do
  end


  def cancel_act do
  end

end
