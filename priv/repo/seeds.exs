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

