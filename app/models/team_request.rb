class TeamRequest < ActiveRecord::Base
  belongs_to :requestor, class_name: 'User', foreign_key: 'requestor_id'
  belongs_to :receptor, class_name: 'User', foreign_key: 'receptor_id'
  attr_accessible :deleted_at, :requestor_id, :receptor_id

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
      TeamMember.create! team: Team.first, user: self.user
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
    self.class.where(team: Team.first).active.all(lock: true)
  end

  def active
    self.class.where(deleted_at: nil)
  end

end
