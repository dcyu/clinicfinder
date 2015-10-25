class Clinic < ActiveRecord::Base
  has_many :shifts, dependent: :destroy
  accepts_nested_attributes_for :shifts
end
