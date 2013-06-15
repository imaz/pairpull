class TeamRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  attr_accessible :deleted_at

  def add requestor
    self.class.transaction do
      self.users = requestor
      self.save!
    end
  end

  def accept acceptor
    self.class.transaction do
      self.serialize_lock
      raise "Invalid accepter" unless Team.joind_member?(acceptor)
      TeamMember.create! team: self.team, user: self.user
    end
  end

  def reject rejector
    self.class.transaction do
      self.serialize_lock
      raise "Invalid accepter" unless Team.joined_member?(acceptor)
      self.destroy
    end
  end

  def serialize_lock
    # Lock
    self.class.where(team: self.team).active.all(lock: true)
  end

  def active
    self.class.where(deleted_at:, nil)
  end

end
