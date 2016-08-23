class AddBankToInstance < ActiveRecord::Migration[5.0]
  def change
    add_column :instances, :bank, :integer
  end
end
