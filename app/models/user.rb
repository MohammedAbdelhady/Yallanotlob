class User < ApplicationRecord
    has_many :group_users
    has_many :groups, through: :group_users
    has_many :orders
    has_many :order_friends
    has_many :invitations ,:through => :order_friends , :source =>'order'
    has_many :order_items
end
