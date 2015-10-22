class CreateClinics < ActiveRecord::Migration
  def change
    create_table :clinics do |t|
      t.string :name
      t.integer :organization_id
      t.string :lat
      t.string :lng
      t.text :address
      t.text :operating_hours
      t.string :cost
      t.string :scheduling
      t.string :eligibility
      t.string :country

      t.timestamps null: false
    end
  end
end
