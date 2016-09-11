class AddRoundValueToCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :round_value, :integer
  end
end
