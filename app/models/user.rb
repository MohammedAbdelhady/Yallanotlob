class User < ApplicationRecord
    
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
            
    def generate_password_token!
        begin
            self.reset_password_token = SecureRandom.urlsafe_base64
        end while User.exists?(reset_password_token: self.reset_password_token)
        self.reset_password_token_expires_at = 1.day.from_now
    end
    
    def clear_password_token!
        self.reset_password_token = nil
        self.reset_password_token_expires_at = nil
        save!
    end
  
    has_many :group_users
    has_many :groups, through: :group_users
    has_many :orders , dependent: :destroy
    has_many :order_friends
    has_many :invitations ,:through => :order_friends , :source =>'order'
    has_many :order_items

    has_many :followed_users, foreign_key: :follower_id, class_name: 'Friendship'
    has_many :followees, through: :followed_users

    has_many :following_users, foreign_key: :followee_id, class_name: 'Friendship'
    has_many :followers, through: :following_users , dependent: :destroy

    has_many :notifications, foreign_key: "recipient_id" ,dependent: :destroy
end
