defmodule StripeAppWeb.PlanController do
  use StripeAppWeb, :controller

  alias StripeApp.Products
  alias StripeApp.Products.Plan

  def index(conn, _params) do
    plans = Products.list_plans()
    render(conn, "index.html", plans: plans)
  end

  def show(conn, %{"id" => id}) do
    plan = Products.get_plan!(id)
    render(conn, "show.html", plan: plan)
  end

end
