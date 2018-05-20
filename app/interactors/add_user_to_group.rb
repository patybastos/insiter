class AddUserToGroup
  include Interactor

  def call
    fail! message: I18n.t('admin.trestle.flash.too_young') unless is_old_enough_to_join_group?
    fail! message: I18n.t('admin.trestle.flash.too_many_groups') unless group_limit_reached?

    if create_new_user_group
      context[:message] = I18n.t('admin.trestle.flash.successfully_joined_group')
    else
      fail! message: I18n.t('admin.trestle.flash.could_not_join_group')
    end
  end

  private

  def group_limit_reached?
    context[:user].groups.count >= User::MAX_NUMBER_OF_GROUPS
  end

  def is_old_enough_to_join_group?
    context[:user].age >= context[:group].minimum_age
  end

  def create_new_user_group
    context[:user_group] = UserGroup.new(user_id: context[:user].id, group_id: context[:group].id)
    context[:user_group].save
  end
end
