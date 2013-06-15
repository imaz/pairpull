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
    #self.team_members.count <= self::MAX_MEMBER
  end

  def add_request requestor
    req = TeamRequest.new
    req.team = self.team
    req.add requestor
  end

  def skip_logging wish_id
      logger.info(self.to_log_format(wish_id, "wish_skip"))
  end

  def to_log_format wish_id, log_type
    {
      log_type: log_type,
      wish_id: wish_id,
      team_id: self.id,
    }
  end
end
