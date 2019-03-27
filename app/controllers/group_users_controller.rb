class GroupUsersController < ApplicationController
  before_action :authorize_request
  #POST /group_users
  def create

    @group_friend = GroupUser.new({group_id: params[:group_id], user_id: params[:friend_id], owner: 0})

    if @group_friend.save
      render json: @group_friend, status: :created, location: @group_friend
    else
      render json: @group_friend.errors, status: :unprocessable_entity
    end

  end

# DELETE /friendships
def removeFriendFromGroup
  @group_friend = GroupUser.where(group_id: params[:group_id]).where(user_id: params[:friend_id])[0]
  if @group_friend.destroy
    render json: {"status" => "success"}
  else
    render json: @group_friend.errors, status: :unprocessable_entity
  end
end

end
