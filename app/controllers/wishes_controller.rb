class WishesController < ApplicationController
  def pull
    team_id = params[:team_id]
    @team = Team.find(team_id)
    if @team.current_wish.nil?
      @team.current_wish = @team.wishes.where(done: false).sample
      @team.save
    end
    redirect_to team_path team_id
  end

  def create
    Wish.create!(params[:wish])
    redirect_to team_path params[:team_id]
  end
end
