class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :team_members
  has_many :teams, through: :team_members

  def joined_teams
    team_ids = TeamMember.where(user_id: self).pluck(:team_id)
    TeamMember.where(team_id: team_ids).where("user_id != ?", self).includes(:user).all
  end
end
