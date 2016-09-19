class AddMailContactToCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :mail_contract, :integer
  end
end
