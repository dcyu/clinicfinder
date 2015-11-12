class AddVerifiedToClinics < ActiveRecord::Migration
  def change
    add_column :clinics, :verified, :boolean
  end
end
