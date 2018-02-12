# Setting up Stripe App

## Requirements

This app allows users to purchase and access books or plans.  The books have purchase prices 
and the plans have monthly prices.  

To keep things simple, we will initially have four books and one plan, and each book consists of 
a single page.  The users have no access to books or plans in the beginning. After purchasing a 
book, an user is allowed to view the book, whereas after purchasing the plan, an user is allowed 
to view all books. Users can also cancel plans.

An user with admin access can add or remove books, raise or lower prices and so on.


## Step 1.  Prepare the project.

Start with 'coherence_demo_confirm' and to create a project named 'StripeApp'.

~~~~~~~~~~
cleanup-coherence.perl coherence_demo_confirm StripeApp stripe_app
~~~~~~~~~~

add stripe library in mix.exs -

~~~~~~~~~~
{:stripe, "~> 0.7.1", hex: :stripe_elixir}
~~~~~~~~~~

add stripe secret key in config/config.ex -

~~~~~~~~~~
# Stripe
config :stripe, :secret_key, System.get_env("STRIPE_SECRET_KEY")
~~~~~~~~~~



~~~~~~~~~~
mix do deps.get; deps.compile
cd assets && npm install
~~~~~~~~~~

It includes the following migrations and corresponding repos.
~~~~~~~~~~
20170803154232_create_posts.exs
20170803154908_create_coherence_user.exs
20170803154909_create_coherence_invitable.exs
20170803154910_create_coherence_rememberable.exs
~~~~~~~~~~


## Step 2. Create Ecto Repos

~~~~~~~~~~
mix ecto.setup
~~~~~~~~~~

Create the following four paths using [mix phx.gen.html](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Html.html).

~~~~~~~~~~
mix phx.gen.html Products Book books title:string author:string image:string url:string price:float visible:boolean
mix phx.gen.html Products Plan plans name:string stripe_id:string price:float interval:datetime visible:boolean
mix phx.gen.html Products Getbook getbooks user_id:binary_id book_id:binary_id stripe_cus_id:string stripe_charge_id:string price:float
mix phx.gen.html Products Getplan getplans user_id:binary_id plan_id:binary_id status:integer stripe_cus_id:string stripe_sub_id:string price:float
~~~~~~~~~~


### 1. create_books.exs 

~~~~~~~~~~
defmodule StripeApp.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :author, :string
      add :image, :string
      add :url, :string
      add :price, :float
      add :visible, :boolean, default: false, null: false

      timestamps()
    end

  end
end
~~~~~~~~~~


### 2. create_plans.exs 

~~~~~~~~~~
defmodule StripeApp.Repo.Migrations.CreatePlans do
  use Ecto.Migration

  def change do
    create table(:plans) do
      add :name, :string
      add :stripe_id, :string
      add :price, :float
      add :interval, :naive_datetime
      add :visible, :boolean, default: false, null: false

      timestamps()
    end

  end
end
~~~~~~~~~~


### 3. create_get_books.exs 

~~~~~~~~~~
defmodule StripeApp.Repo.Migrations.CreateGetbooks do
  use Ecto.Migration

  def change do
    create table(:getbooks) do
      add :user_id, :binary_id
      add :stripe_cus_id, :string
      add :stripe_charge_id, :string
      add :book_id, :integer
      add :price, :float

      timestamps()
    end

  end
end
~~~~~~~~~~

### 4. create_get_plans.exs 

~~~~~~~~~~
defmodule StripeApp.Repo.Migrations.CreateGetplans do
  use Ecto.Migration

  def change do
    create table(:getplans) do
      add :user_id, :binary_id
      add :stripe_cus_id, :string
      add :stripe_sub_id, :string
      add :plan_id, :integer
      add :status, :integer
      add :price, :float

      timestamps()
    end

  end
end
~~~~~~~~~~

A guide on seeding data is [here](http://phoenixframework.org/blog/seeding-data).

Here is our seeds.ex -

~~~~~~~~
alias StripeApp.Repo
alias StripeApp.Products.Book
alias StripeApp.Products.Plan

import Ecto.Query, warn: false

StripeApp.Repo.delete_all StripeApp.Coherence.User

StripeApp.Coherence.User.changeset(%StripeApp.Coherence.User{}, %{name: "Demo User 1", email: "demouser1@example.com", password: "secret", password_confirmation: "secret"})
|> StripeApp.Repo.insert!
|> Coherence.Controller.confirm!

StripeApp.Coherence.User.changeset(%StripeApp.Coherence.User{}, %{name: "Demo User 2", email: "demouser2@example.com", password: "secret", password_confirmation: "secret"})
|> StripeApp.Repo.insert!
|> Coherence.Controller.confirm!

Repo.insert! %Book{title: "Python for Arduino", author: "Cool Programmer", image: "https://www.python.org/static/opengraph-icon-200x200.png", price: 8.49, url: "hspython1", visible: true}

Repo.insert! %Book{title: "R for Data Science", author: "Stat Writer", image: "/images2/R-cover.png", price: 8.99, url: "R", visible: true}

Repo.insert! %Book{title: "How Dinos are Caught", author: "Zoo Author", image: "/images2/dino-cover.png", price: 9.49, url: "vision", visible: true}

Repo.insert! %Book{title: "See and Believe", author: "See Believer", image: "/images2/geez-cover.png", price: 9.99, url: "rnaseq", visible: true}

Repo.insert! %Plan{name: "Tutorial", price: 4.99, stripe_id: "Tutorial", visible: true }
~~~~~~~~


Also add the following resources under 'pipe_through :protected' -

~~~~~~~~~~
resources "/books", BookController
resources "/plans", PlanController
resources "/getbooks", GetbookController
resources "/getplans", GetplanController
~~~~~~~~~~


Now run -

~~~~~~~~~~
mix ecto.setup
~~~~~~~~~~

Your database is ready.


## Step 4. Add AdminbookController and AdminplanController

We create two separate BookControllers and PlanControllers. The regular BookController and 
PlanController has only index and show. AdminbookController has restricted access, whereas 
BookController can be accessed by all users.

The current BookController is copied into AdminbookController with full access to change, 
update and delete options.  The view and template are also duplicated. The files were
internally changed with book_controller references to adminbook_controller.

In the book and plan controllers, paths edit,new,delete are removed. Also, the 'visible'
option is activated.

Add this to router.ex -

~~~~~~~~~~
resources "/adminbooks", BookController
resources "/adminplans", PlanController
~~~~~~~~~~

## Step 5. Add New Functionality in GetbookController and GetplanController

This block receives stripe payments. We have a number of possibilities -

(i)	person buys on a new card,
(ii)	person buys on an existing card,
(iii)	person wants to cancel purchase/plan,

~~~~~~~
    post "/getbooks/new_card", GetbookController, :new_card
    post "/getbooks/existing_card", GetbookController, :existing_card
    get "/getbooks/:id/card", GetbookController, :card

    get "/getplans/:id/card", GetplanController, :card
    post "/getplans/new_card", GetplanController, :new_card
    post "/getplans/existing_card", GetplanController, :existing_card
~~~~~~~

### Stripe Functional Logic

step 1 - create a customer (cus ID) - [stripe customer token for user, last 4]
step 2 - charge (subscribe to plan)

Procedure -

First time subscription -> store customer token.
If customer has token, ask whether to use it or change card.
Otherwise, create a form to get credit card information and use it.

### Pricing Logic

If user is subscribed, check when it ends. Allow access until cancel date.
If user is not subscribed,  allow two subscriptions.




## Step 6. Control Access Based on Payment

We allow reading books using a separate function in BookController called 'read'.

(i) create bookcontroller function read. Remember to include Ecto.Query library.

(ii) create template/book/read.html

(iii) Edit route.ex -

~~~~~~~
get "/books/:id/read", BookController, :read
~~~~~~~

## Step 7. Show purchases in user panel



## Step 8. stripe webhooks for plan


