class Clinic < ActiveRecord::Base
  has_many :shifts, dependent: :destroy
  accepts_nested_attributes_for :shifts

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :lat, presence: true
  validates :lng, presence: true
  validates :country, presence: true

end
