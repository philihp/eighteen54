class AddCostToCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :cost, :integer
  end
end
