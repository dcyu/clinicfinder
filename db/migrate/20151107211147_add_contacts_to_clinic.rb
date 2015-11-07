class AddContactsToClinic < ActiveRecord::Migration
  def change
    add_column :clinics, :contact_name, :string
    add_column :clinics, :contact_email, :string
    add_column :clinics, :contact_phone, :string
    add_column :clinics, :additional_info, :text
  end
end
