class AddNeedsToOperateToCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :needs_to_operate, :boolean
  end
end
