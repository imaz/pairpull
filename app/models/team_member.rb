class TeamMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  # attr_accessible :title, :body
end
