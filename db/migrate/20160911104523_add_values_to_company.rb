class AddValuesToCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :value_x, :integer
    add_column :companies, :value_y, :integer
  end
end
