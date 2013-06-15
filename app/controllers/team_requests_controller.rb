class TeamRequestsController < ApplicationController
  def create
    receptor = User.find_by_name(params[:user_name])
    if receptor
      TeamRequest.new.add current_user, receptor
      flash[:team_request] = 'Requested'
    else
      flash[:team_request] = 'Invalid user name'
    end
    redirect_to user_path current_user
  end

  def accept
    TeamRequest.find(params[:id]).accept current_user
    redirect_to user_path current_user
  end

  def reject
    TeamRequest.find(params[:id]).reject current_user
    redirect_to user_path current_user
  end
end
