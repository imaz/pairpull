class WishesController < ApplicationController
  def pull
    team_id = params[:team_id]
    @team = Team.find(team_id)
    @team.current_wish = @team.wishes.where(done: false).sample
    @team.save
    redirect_to team_path team_id
  end
end
