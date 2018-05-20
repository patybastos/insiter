class UserGroupsController
  def create
    result = AddUserToGroup.call group: @group, user: current_user
    message = result.message

    if result.success?
      flash[:notice] = message
    else
      flash[:alert] = message
    end

    redirect_to group_path(@group)
  end
end
