class TeamRequestsController < ApplicationController
  def create
    user = User.find_by_name(params[:user_name])
    if @user
      team_request = TeamRequest.new
      team_request.user = user
    end
    redirect_to user_path current_user
  end

  def index
  end

  def destroy
  end
end
