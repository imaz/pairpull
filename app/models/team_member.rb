class TeamMember < ActiveRecord::Base
  belongs_to :users
  belongs_to :team
  # attr_accessible :title, :body
end
