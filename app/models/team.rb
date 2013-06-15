class Team < ActiveRecord::Base
  attr_accessible :current_wish_id
  belongs_to :current_wish, class_name: 'Wish', foreign_key: 'current_wish_id'
  has_many :wishes
end
