class SubscriptionsController < ApplicationController
    skip_before_action :authenticate_user
    def index
        render json: SubscriptionPlan.all
    end
    def create
        @subscription = Subscription.create(user_id: 6, 
                                            subscription_plan_id: get_plan_id_from_subscription_plans(params[:plan_id]), 
                                            rajorpay_subscription_id: params[:id] )
        if @subscription
            render json: { message: @subscription }, status: :created
        else
            render json: { message: 'something went wrong' }, status: :unprocessable_entity
        end
    end
    def subscription_params
        params.permit(:id, :plan_id)
    end

    private
    def get_plan_id_from_subscription_plans(plan_id)
        SubscriptionPlan.find_by(rajorpay_plan_id: plan_id).id
    end
end
