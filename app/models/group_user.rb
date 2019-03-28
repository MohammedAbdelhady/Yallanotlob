class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user

  scope :not_owners, -> { where(owner: '0') }
  scope :is_owner, -> { where(owner: '1') }
end
