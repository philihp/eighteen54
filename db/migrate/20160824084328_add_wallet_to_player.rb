class AddWalletToPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :wallet, :integer
  end
end
