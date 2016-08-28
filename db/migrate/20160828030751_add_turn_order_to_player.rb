class AddTurnOrderToPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :turn_order, :integer
  end
end
