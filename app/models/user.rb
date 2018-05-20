class User < ApplicationRecord
  MAX_NUMBER_OF_GROUPS = 10

  has_many :user_groups
  has_many :groups, through: :user_groups

  def is_old_enough_to_join_group?(group)
    age > group.minimum_age
  end

  def is_group_limit_reached?
    groups.count >= MAX_NUMBER_OF_GROUPS
  end
end
