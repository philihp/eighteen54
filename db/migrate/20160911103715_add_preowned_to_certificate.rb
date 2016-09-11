class AddPreownedToCertificate < ActiveRecord::Migration[5.0]
  def change
    add_column :certificates, :preowned, :boolean
  end
end
