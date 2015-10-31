class Clinic < ActiveRecord::Base
  has_many :shifts, dependent: :destroy
  has_many :capabilities, dependent: :destroy
  has_many :topics, through: :capabilities
  
  accepts_nested_attributes_for :shifts
  accepts_nested_attributes_for :capabilities

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :lat, presence: true
  validates :lng, presence: true
  validates :country, presence: true

end
