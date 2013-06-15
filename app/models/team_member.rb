class TeamMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  attr_accessible :user, :team

  before_create do |record|
    raise "Over capacity" if record.team.over_capacity?
  end
end
