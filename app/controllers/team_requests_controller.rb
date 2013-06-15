class TeamRequestsController < ApplicationController
  def create
    receptor = User.find_by_name(params[:user_name])
    if receptor
      TeamRequest.add current_user, receptor
      flash[:team_request] = 'Requested'
    else
      flash[:team_request] = 'Invalid user name'
    end
    redirect_to user_path current_user
  end

  def index
  end

  def destroy
  end
end
