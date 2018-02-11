class HooksController < ApplicationController

	protect_from_forgery :except => :webhook

	def webhook

		require "json"

		event_json = JSON.parse request.body.read
		event = Stripe::Event.retrieve(event_json["id"])

		####################################################
		#
		#	'subscription deleted' event
		#
		####################################################
		if(event['type']=='customer.subscription.deleted')
			@bought=PlanPurchase.where(stripe_sub_id: event['data']['object']['id']).where(status: 1).first
			if @bought.present?
                		@bought.status=0
                		@bought.save
			else
				print event['data']['object']['id']
			end
		end

		# 'ok' response to Stripe
		head 200
	end
end
