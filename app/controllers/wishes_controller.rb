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
    Wish.transaction do
      w = Wish.new params[:wish]
      w.add params[:wish][:title]
    end
    redirect_to team_path params[:team_id]
  end

  def done
    team_id = params[:team_id]
    Team.transaction do |t|
      team = Team.find(team_id, lock: true)
      unless team.current_wish.nil?
        wish = Wish.find(team.current_wish_id, lock: true)
        wish.exec_done
        team.current_wish = nil
        team.save!
      end
    end
    redirect_to team_path team_id
  end

  def skip
    team_id = params[:team_id]
    Team.transaction do |t|
      team = Team.find(team_id, lock: true)
      unless team.current_wish.nil?
        team.current_wish = team.wishes.where(done: false).sample
        team.save!
        team.skip_logging team.current_wish.id
      end
    end
    redirect_to team_path team_id
  end
end
