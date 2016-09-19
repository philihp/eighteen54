class AddMailContactsToInstance < ActiveRecord::Migration[5.0]
  def change
    add_column :instances, :small_mail_contract, :integer
    add_column :instances, :large_mail_contract, :integer
  end
end
