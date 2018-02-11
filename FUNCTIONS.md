# Stripe Functional Logic



Subscription Load (0.3ms)  SELECT  "subscriptions".* FROM "subscriptions" WHERE "subscriptions"."id" = ? LIMIT 1  [["id", 1]]
=> #<Subscription id: 1, stripe_id: "cus_8DruelWdC6ruNY", plan_id: 1, last_four: "4242", coupon_id: nil, card_type: "undefined", current_price: 4.99, user_id: 1, created_at: "2016-04-06 23:35:04", updated_at: "2016-04-11 14:51:11">


func upgrade, downgrade
        cancel previous one
        subscribe

func cancel

func show current subscription

func change card

func yearly_sub

func referral_discount

Initial registration --> invited by  - include in devise user


stripe -

step 1 - create a customer (cus ID) - [stripe customer token for user, last 4]
step 2 - charge (subscribe to plan)

Procedure -

First time subscription -> store customer token.
If customer has token, ask whether to use it or change card.
Otherwise, create a form to get credit card information and use it.



## Pricing Logic

If user is subscribed, check when it ends. Allow access until cancel date.
If user is not subscribed,  allow two subscriptions.


