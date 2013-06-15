class UsersController < ApplicationController
  def show
    @requestors = TeamRequest.where(receptor_id: current_user.id).map{|request| request.requestor }
  end
end
