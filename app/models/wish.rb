class Wish < ActiveRecord::Base
  belongs_to :team
  attr_accessible :done, :title, :team_id

  before_create do |record|
    raise "Must team" if record.team.nil?
  end

  def add title
    self.title = title
  end


  def done
    self.class.transaction do
      obj = self.team.class.find(self.team, lock: true)
      obj.current_wish = nil
      obj.save!
      self.done = true
      self.save!
    end
  end

end
