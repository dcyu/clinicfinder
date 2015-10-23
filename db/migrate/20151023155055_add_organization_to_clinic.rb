class AddOrganizationToClinic < ActiveRecord::Migration
  def change
    remove_column :clinics, :organization_id, :integer
    add_column :clinics, :organization, :string
  end
end
