require 'fluent-logger'
class Wish < ActiveRecord::Base
  belongs_to :team
  attr_accessible :done, :title, :team_id

  before_create do |record|
    raise "Must team" if record.team.nil?
  end

  def add title
    self.class.transaction do
      self.title = title
      self.save!
      Fluent::Logger.post("wish_add", self.to_log_format)
    end
  end


  def exec_done
    self.class.transaction do
      obj = self.team.class.find(self.team, lock: true)
      obj.current_wish = nil
      obj.save!
      self.done = true
      self.save!
      Fluent::Logger.post("wish_done", self.to_log_format)
    end
  end


  def to_log_format
    {
      wish_id: self.id,
      team_id: self.team_id,
    }
  end
end
