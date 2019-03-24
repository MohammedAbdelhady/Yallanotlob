class Order < ApplicationRecord
  belongs_to :user
  has_many :order_friends
  has_many :invited_friends,:through => :order_friends ,:source => 'user'
  has_many :order_items
end
 