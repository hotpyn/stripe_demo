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
    resources "/getbooks", GetbookController
    resources "/getplans", GetplanController

    resources "/posts", PostController
    resources "/users", UserController
    put "/lock/:id", UserController, :lock
    put "/unlock/:id", UserController, :unlock
    put "/confirm/:id", UserController, :confirm
  end

  # Other scopes may use custom stacks.
  # scope "/api", StripeAppWeb do
  #   pipe_through :api
  # end
end
