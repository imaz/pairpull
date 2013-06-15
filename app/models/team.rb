class Team < ActiveRecord::Base
  belongs_to :current_wish, class_name: 'Wish', foreign_key: 'current_wish_id'
  attr_accessible :current_wish_id
end
