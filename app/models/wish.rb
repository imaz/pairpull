class Wish < ActiveRecord::Base
  belongs_to :team
  attr_accessible :done, :title
end
