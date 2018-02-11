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
mix phx.gen.html Products Getbook getbooks user_id:integer book_id:integer stripe_charge_id:string price:float
mix phx.gen.html Products Getplan getplans user_id:integer plan_id:integer status:integer stripe_sub_id:string price:float
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

seeds.ex -

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

Your database will be ready.


## Step 4. New Controllers

adminbook_controller

adminplan_controller


## Step 5. New functionalities


