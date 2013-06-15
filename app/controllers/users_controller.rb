class UsersController < ApplicationController
  def show
    @team_requests = TeamRequest.where(receptor_id: current_user.id)
  end
end
