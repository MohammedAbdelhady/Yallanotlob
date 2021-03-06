class PasswordResetController < ApplicationController
    before_action :set_user, only: [:edit, :update]
    KEYS = [:password, :password_confirmation].freeze

    def create
      @user = User.find_by(email: params[:email])
      if @user
        @user.generate_password_token!
        if @user.save
        UserMailer.reset_password(@user).deliver_now
        render json: :ok
        end
      end

    end

    def edit
        render json: :ok
    end
    
    def update
        @user.update!(password_params)
        @user.clear_password_token!
        render json: {status: "success", message: 'Password Changed Successfuly' }, status: :ok
    end
    
    
    private
    
    def set_user
        @user = User.find_by(reset_password_token: params[:token])
        if @user&.reset_password_token_expires_at && @user.reset_password_token_expires_at > Time.now
        else
            render json: { error: 'Not authorized' }, status: :unauthorized
        end
    end

    def password_params
        params.tap { |p| p.require(KEYS) }.permit(*KEYS)
    end

  end