class User < ApplicationRecord
    has_many :group_users
    has_many :groups, through: :group_users
    has_many :orders
    has_many :order_friends
    has_many :invitations ,:through => :order_friends , :source =>'order'
    has_many :order_items

    has_many :followed_users, foreign_key: :follower_id, class_name: 'Friendship'
    has_many :followees, through: :followed_users

    has_many :following_users, foreign_key: :followee_id, class_name: 'Friendship'
    has_many :followers, through: :following_users

    has_many :notifications, foreign_key: "recipient_id"
end
