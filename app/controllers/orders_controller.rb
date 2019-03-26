class OrdersController < ApplicationController
  before_action :authorize_request
  before_action :set_order , only: [:show, :update, :destroy]
  
  # GET /orders
  def index
    @user = User.find(params[:user_id])
    @orders = @user.orders 
    @invites = @user.invitations
    render json: {orders: @orders ,invitedAt: @invites}
  end

  # POST /orders
  def create

    invitedFriends = params[:invited]
    @order = Order.new(order_params)
    @order.user = User.find(params[:user_id])
    
    if @order.save
      friends = invitedFriends.map { |e| User.find (e[:id])  }  
      @order.invited_friends = friends  
      render json: { msg: "Successful"} # , status: :created #, location: @order
    
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end
  # DELETE /orders/1
  def destroy
    # @order = Order.find(params[:id])
    if @order.destroy
      render json: {msg: "Order Deleted Successfuly"}
    end
  end

  def get_invited_friends

    @order = Order.find(params[:id])
    invited = User.select('users.*,order_friends.user_status').
    joins(:order_friends).where('order_id =? ',@order.id)
    
    joined = User.select('users.*,order_friends.user_status').
    joins(:order_friends).where('order_id =? and user_status = "joined"',@order.id)

    render json: { allInvitated: invited  , accepted: joined}
  end

  def join_order
    @order = Order.find(params[:id])
    @user = User.find(params[:user_id])

    order = OrderFriend.where('order_id = ? and user_id = ?',params[:id],params[:user_id]).first

    if order.update_attributes(:user_status => "joined")
      render json: { msg: "Updated"} , status: :created #, location: @order
    else
      render json: order.errors, status: :unprocessable_entity
    end
  end

  def finish_order
    @order = Order.find(params[:id])

    if @order.update_attributes(:order_status => "finished")
      render json: { msg: "Order Has Finished"} , status: :created #, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end

  end
  def remove_invitation

    friend_invited = OrderFriend.where('order_id =? and user_id = ?',params[:order_id],params[:user_id]).first

    if friend_invited.destroy
      render json: { msg: "Removed from order invitations"}
    end

  end
  private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:order_type, :restaurant, :menu_image)
    end
end
