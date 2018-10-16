defmodule StripeAppWeb.Router do
  use StripeAppWeb, :router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true  # Add this
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Add this block
  #scope "/" do
  scope "/Members" do
    pipe_through :browser
    coherence_routes()
  end

  # Add this block
  #scope "/" do
  scope "/Members" do
    pipe_through :protected
    coherence_routes :protected
  end

  #scope "/", StripeAppWeb do
  scope "/Members", StripeAppWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  #scope "/", StripeAppWeb do
  scope "/Members", StripeAppWeb do
    pipe_through :protected # Use the default browser stack

    resources "/books", BookController
    resources "/plans", PlanController
    resources "/adminbooks", AdminbookController
    resources "/adminplans", AdminplanController

    resources "/posts", PostController
    resources "/users", UserController
    put "/lock/:id", UserController, :lock
    put "/unlock/:id", UserController, :unlock
    put "/confirm/:id", UserController, :confirm

    post "/buybooks/new_card", BuybookController, :new_card
    post "/buybooks/existing_card", BuybookController, :existing_card
    get "/buybooks/:id/new", BuybookController, :new

    get "/books/:id/read", BookController, :read

    get "/buyplans/:id/new", BuyplanController, :new
    get "/buyplans/:id/cancel", BuyplanController, :cancel
    get "/buyplans/cancel_sure", BuyplanController, :cancel_sure
    post "/buyplans/new_card", BuyplanController, :new_card
    post "/buyplans/existing_card", BuyplanController, :existing_card

  end

end
