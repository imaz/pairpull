class UsersController < ApplicationController
  def show
    @team_members = current_user.joined_teams
    @team_requests = TeamRequest.where(receptor_id: current_user.id)
  end
end
