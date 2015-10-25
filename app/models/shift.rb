class Shift < ActiveRecord::Base
  belongs_to :clinic
  validates :day, presence: true
end