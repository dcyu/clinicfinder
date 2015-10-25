class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.string :day
      t.string :opening_time
      t.string :closing_time
      t.integer :clinic_id
    end
  end
end
