class Shift < ActiveRecord::Base
  belongs_to :clinic
  validates :day, presence: true
  validate :unique_days, on: :create

  def unique_days
    if Shift.where(clinic_id: self.clinic_id, day: self.day).count > 0
      errors.add(:day, "must be unique")
    end
  end

end