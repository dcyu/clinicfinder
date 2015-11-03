class AddMoreTimesToShifts < ActiveRecord::Migration
  def change
    add_column :shifts, :opening_time2, :string
    add_column :shifts, :closing_time2, :string
  end
end
