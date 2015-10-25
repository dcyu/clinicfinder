class AddOpenToShifts < ActiveRecord::Migration
  def change
    add_column :shifts, :open, :boolean
  end
end
