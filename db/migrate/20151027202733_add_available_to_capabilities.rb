class AddAvailableToCapabilities < ActiveRecord::Migration
  def change
    add_column :capabilities, :available, :boolean
  end
end
