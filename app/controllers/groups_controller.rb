class GroupsController < ApplicationController
  before_action :authorize_request
  # GET /groups/:group_id/
  def group_users
    @group = Group.find(params[:group_id])
    @users = @group.users.merge(GroupUser.not_owners)
    render json: @users.to_a
  end

  # GET /groups/1
  def show
    render json: @group
  end

  # POST /groups
  def create
    @group = Group.new(name: params[:name])

    if @group.save
      @group_user = GroupUser.new({group_id: @group.id, user_id: params[:user_id], owner: 1})

      if @group_user.save
        render json: @group, status: :created, location: @group_friend
      else
        render json: @group_friend.errors, status: :unprocessable_entity
      end

    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /groups/1
  def update
    if @group.update(group_params)
      render json: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /groups/1
  def destroy
    @group = Group.find(params[:id])
    if @group.destroy
      render json: {"status" => "success"}
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def group_params
      params.require(:group).permit(:name)
    end
end
