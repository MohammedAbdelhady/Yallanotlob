class OrderItemsController < ApplicationController
    before_action :authorize_request
    def create
        @order_item = OrderItem.new(order_item_params)

        @order_item.order = Order.find(params[:order_id])
        @order_item.user = User.find(params[:user_id])
        
        if @order_item.save
          render json: @order_item , status: :created #, location: @order
        else
          render json: @order.errors, status: :unprocessable_entity
        end
    end

    def destroy
        order_item = OrderItem.find(params[:id])
        if order_item.destroy
            render json: { msg: "Deleted"}
        end
    end

    def get_order_details
        @order = Order.find(params[:id])

        order_details = OrderItem.select('users.name as userName,users.email,order_items.*').
        joins(:user).where('order_id =? ',@order.id).order('order_items.created_at DESC')
        
        render json: {order: @order ,order_details: order_details}
    end

    private 

    def order_item_params
        params.require(:order_item).permit(:item, :amount, :price ,:comment)
    end

end
