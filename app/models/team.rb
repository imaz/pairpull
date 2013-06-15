class Team < ActiveRecord::Base
  attr_accessible :current_wish_id
  belongs_to :current_wish, class_name: 'Wish', foreign_key: 'current_wish_id'
  has_many :wishes
  has_many :team_requests
  has_many :team_members

  MAX_MEMBER = 2

  def filter_member member
    self.include_member.where("team_members.user_id", member)
  end

  def include_member
    self.include :team_members
  end

  def joined_member? member
    self.filter_member(member).count > 0
  end

  def over_capacity?
    self.members.count <= self::MAX_MEMBER
  end

  def add_request requestor
    req = TeamRequest.new
    req.team = self.team
    req.add requestor
  end

end
