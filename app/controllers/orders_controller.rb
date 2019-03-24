class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]

  # GET /orders
  def index
    @orders = Order.all
    render json: @orders
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # POST /orders
  def create

    invitedFriends = params[:invited]
    @order = Order.new(order_params)
    @order.user = User.find(params[:user_id])
    

    if @order.save
      friends = invitedFriends.map { |e| User.find (e)  }  
      # friends = invitedFriends.each do |id|
          # usr = User.find(id)
        # @order.invited_friends << user
        # end 
      @order.invited_friends = friends  
    
      # @order.invited_friends
      render json: { order: @order , friends: @order.invited_friends.to_a} , status: :created #, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.permit(:order_type, :restaurant, :menu_image)
    end
end
