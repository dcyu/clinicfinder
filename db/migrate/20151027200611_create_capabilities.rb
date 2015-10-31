class CreateCapabilities < ActiveRecord::Migration
  def change
    create_table :capabilities do |t|
      t.integer :topic_id
      t.integer :clinic_id
    end
  end
end
