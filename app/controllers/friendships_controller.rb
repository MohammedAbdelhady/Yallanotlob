class FriendshipsController < ApplicationController

  #POST /friendships
  def create
    @friendship = Friendship.new(friendship_params)

    if @friendship.save
      render json: @friendship, status: :created, location: @friendship
    else
      render json: @friendship.errors, status: :unprocessable_entity
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

  private
 
    # Only allow a trusted parameter "white list" through.
    def friendship_params
      params.require(:friendship).permit(:follower_id, :followee_id)
    end
end
