class AddStockRoundsToInstance < ActiveRecord::Migration[5.0]
  def change
    add_column :instances, :stock_rounds, :integer
  end
end
