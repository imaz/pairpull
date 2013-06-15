class TeamRequest < ActiveRecord::Base
  belongs_to :requestor, class_name: 'User', foreign_key: 'requestor_id'
  belongs_to :receptor, class_name: 'User', foreign_key: 'receptor_id'
  attr_accessible :deleted_at, :requestor_id, :receptor_id

  def add requestor, receptor
    self.class.transaction do
      self.requestor = requestor
      self.receptor = receptor
      self.save!
    end
  end

  def accept acceptor
    self.class.transaction do
      lock = self.serialize_lock
      if lock.deleted_at.present?
        raise 'Already deleted'
      end
      unless acceptor == receptor
        raise 'Invalid request'
      end

      team = Team.create!
      TeamMember.create! team: team, user: self.requestor
      TeamMember.create! team: team, user: self.receptor
      self.destroy
    end
  end

  def reject rejector
    self.class.transaction do
      lock = self.serialize_lock
      if lock.deleted_at.present?
        raise 'Already deleted'
      end
      unless rejector == receptor
        raise 'Invalid request'
      end

      self.destroy
    end
  end

  def serialize_lock
    # Lock
    self.class.find(self, lock: true)
  end

  def active
    self.class.where(deleted_at: nil)
  end

end
