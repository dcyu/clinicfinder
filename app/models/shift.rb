class Shift < ActiveRecord::Base
  belongs_to :clinic
  validates :day, presence: true, allow_nil: true
  validates :opening_time, presence: true, allow_nil: true
  validates :closing_time, presence: true, allow_nil: true
  validate :unique_days, on: :create
  after_save :require_day

  def unique_days
    if Shift.where(clinic_id: self.clinic_id, day: self.day).count > 0
      errors.add(:day, "must be unique")
    end
  end

  def require_day
    if self.day.blank?
      self.destroy
    end
  end

end