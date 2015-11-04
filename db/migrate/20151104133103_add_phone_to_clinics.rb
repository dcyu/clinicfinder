class AddPhoneToClinics < ActiveRecord::Migration
  def change
    add_column :clinics, :phone, :string
  end
end
