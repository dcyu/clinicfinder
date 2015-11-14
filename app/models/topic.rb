class Topic < ActiveRecord::Base
  has_many :capabilities
  has_many :clinics, through: :capabilities

  def available_clinics
    self.capabilities.where(available: true).map(&:clinic)
  end
end
