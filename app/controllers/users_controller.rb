class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  
  # GET /users/1/groups
  def user_groups
    @user = User.find(params[:user_id])
    @groups = @user.groups
    if @groups
      render json: @groups.to_a
    else
      render json: @groups.errors, status: :unprocessable_entity
    end
  end

  # GET /users/1/friends
  def user_friends
    @user = User.find(params[:user_id])
    @friends = @user.followers
  if @friends
    render json: @friends.to_a
  else
    render json: @friends.errors, status: :unprocessable_entity
  end
  end

  # POST /login
  def login
    @user = User.where(email: params[:email]).where(password: params[:password])[0]

    if(@user)
      render json: {status:"success", user: @user}
    else
      render json: {status:"failed", message: "Invalid Email or Password" }
    end

  end

  # POST /users
  def create

      @user = User.new(user_params)
      @user.password = params[:password]
      @user.password_confirmation = params[:password_confirmation]
      if @user.save
        render json: {status:"success", user: @user}, status: :created, location: @user
      else
        render json: {status:"faild", error: @user.errors}, status: :unprocessable_entity
      end
    
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
 
    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
