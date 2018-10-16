# Setting up Stripe App

## Requirements

This app allows users to purchase and access books or plans.  The books have purchase prices 
and the plans have monthly prices.  

To keep things simple, we will initially have four books and one plan, and each book consists of 
a single page.  The users have no access to books or plans in the beginning. After purchasing a 
book, an user is allowed to view the book, whereas after purchasing the plan, an user is allowed 
to view all books. Users can also cancel plans.

An user with admin access can add or remove books, raise or lower prices and so on.

Six steps -
1. Build a coherence project,
2. Add stripe_cus_id in user model.
3. Create new scaffolds - books, plans, buybooks and buyplans.
4. Add - AdminbookController and AdminplanController
5. Add new function 'read' in BookController with restricted access.
6. Add Stripe-related access logic in Buybooks and Buyplans.  This sixth step is most critical.



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

Add a field stripe__cus_id to user.

In priv/repo/migrations/20170803154908_create_coherence_user.exs, add -

~~~~~~~~~~
      add :stripe__cus_id, :string
~~~~~~~~~~

In lib/stripe_app/coherence/user.ex, add -

~~~~~~~~~~
    field :stripe_cus_id, :string
~~~~~~~~~~

## Step 2. Create Ecto Repos

~~~~~~~~~~
mix ecto.setup
~~~~~~~~~~

Create the following four paths using [mix phx.gen.html](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Html.html).

~~~~~~~~~~
mix phx.gen.html Products Book books title:string author:string image:string url:string price:float visible:boolean
mix phx.gen.html Products Plan plans name:string stripe_id:string price:float interval:datetime visible:boolean
mix phx.gen.html Products Buybook buybooks user_id:binary_id book_id:binary_id stripe_charge_id:string price:float
mix phx.gen.html Products Buyplan buyplans user_id:binary_id plan_id:binary_id status:integer stripe_sub_id:string price:float
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


### 3. create_buy_books.exs 

~~~~~~~~~~
defmodule StripeApp.Repo.Migrations.CreateBuybooks do
  use Ecto.Migration

  def change do
    create table(:buybooks) do
      add :user_id, :binary_id
      add :stripe_charge_id, :string
      add :book_id, :binary_id
      add :price, :float

      timestamps()
    end

  end
end
~~~~~~~~~~

### 4. create_buy_plans.exs 

~~~~~~~~~~
defmodule StripeApp.Repo.Migrations.CreateBuyplans do
  use Ecto.Migration

  def change do
    create table(:buyplans) do
      add :user_id, :binary_id
      add :stripe_sub_id, :string
      add :plan_id, :binary_id
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
resources "/buybooks", BuybookController
resources "/buyplans", BuyplanController
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

## Step 5. Control Access To Books

We allow reading books using a separate function in BookController called 'read'. This
function checks whether the user purchased the book or purchased the plan. If
purchased, the user is allowed access to 'read.html' to read the book. Otherwise the 
user is sent to 'show.html'.

(i) create template/book/read.html

(ii) Edit route.ex to include  -

~~~~~~~~~
get "/books/:id/read", BookController, :read
~~~~~~~~~

(iii) create bookcontroller function read, as shown below.  Note, remember to import 
Ecto.Query.

~~~~~~~~~
defmodule StripeAppWeb.BookController do
  use StripeAppWeb, :controller
  import Ecto.Query, warn: false

  alias StripeApp.Products
  alias StripeApp.Products.Book

  def read(conn, %{"id" => id}) do

    result1 = StripeApp.Repo.all (
         from p in StripeApp.Products.Buybook,
         where: [book_id: ^id, user_id: ^conn.assigns.current_user.id],
         select: p)

    result2 = StripeApp.Repo.all (
         from p in StripeApp.Products.Buyplan,
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
~~~~~~~~~

The function checks Buybook and Buyplan repos. If the user purchased book or
plan, he is allowed to access. At present, no user will be allowed to access anything.


## Step 6. Add New Functionality in BuybookController and BuyplanController

Next let us update Buybook and Buyplan based on Stripe payment. This is where
the core of our logic lies.  We will first implement the basic functionality,
and then improve the code to account for the following possibilities -

(i)	if the user buys on a new card, create a new Stripe customer account.
(ii)	If the user buys on an existing card, use the same Stripe customer account.
(iii)	Allow user to also cancel purchase/plan.
(iv)	Show purchases in user panel.
(v)	Take care of stripe webhooks to show renewal invoices.

Here is how Stripe functional logic works.

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


~~~~~~~
    post "/buybooks/new_card", BuybookController, :new_card
    post "/buybooks/existing_card", BuybookController, :existing_card
    get "/buybooks/:id/new", BuybookController, :new

    get "/buyplans/:id/new", BuyplanController, :new
    post "/buyplans/new_card", BuyplanController, :new_card
    post "/buyplans/existing_card", BuyplanController, :existing_card
~~~~~~~



## References

1.  https://github.com/sikanhe/stripe-elixir
2.  http://www.jaredrader.com/blog/2013/12/18/a-stripe-integration
3.  https://mikesabat.wordpress.com/2013/12/15/making-users-pay-building-a-site-with-strip-and-devise/
4.  https://www.youtube.com/watch?v=hyEsiwc0ys4
5.  http://stackoverflow.com/questions/9628359/using-stripe-with-devise


