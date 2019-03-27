class Order < ApplicationRecord
  belongs_to :user
  has_many :order_friends ,dependent: :destroy
  has_many :invited_friends,:through => :order_friends ,:source => 'user'
  has_many :order_items ,dependent: :destroy
end
 