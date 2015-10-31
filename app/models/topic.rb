class Topic < ActiveRecord::Base
  has_many :capabilities
  has_many :clinics, through: :capabilities
end
