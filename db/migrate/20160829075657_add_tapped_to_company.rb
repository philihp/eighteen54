class AddTappedToCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :tapped, :boolean
  end
end
