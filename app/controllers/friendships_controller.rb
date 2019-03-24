class FriendshipsController < ApplicationController

  #POST /friendships
  def create
    @user = User.where(email: params[:email])[0]

    if(@user)
      @friendship = Friendship.new({follower_id: @user.id,followee_id: params[:user_id]})

      if @friendship.save
        render json: @friendship, status: :created, location: @friendship
      else
        render json: @friendship.errors, status: :unprocessable_entity
      end

    else
      render json: {status:"failed", message: "User not found"}
    end
  end

  # DELETE /friendships
  def unfriend
    @friendship = Friendship.where(follower_id: params[:follower_id]).where(followee_id: params[:followee_id])[0]
    if @friendship.destroy
      render json: {"status" => "success"}
    else
      render json: @friendship.errors, status: :unprocessable_entity
    end
  end

end
