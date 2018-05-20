class UserGroupsController
  def create
    # Assume @group is loaded from a before_action method

    if !current_user.is_old_enough_to_join_group?(@group)
      flash[:alert] = "You are too young to join this group."
    elsif current_user.is_group_limit_reached?
      flash[:alert] = "You have joined too many groups already."
    else
      user_group = UserGroup.new(user_id: current_user.id, group_id: @group.id)
      if user_group.save
        flash[:notice] = "You have successfully joined the #{@group.name} group!"
      else
        flash[:alert] = "Could not join group."
      end
    end

    redirect_to group_path(@group)
  end
end
