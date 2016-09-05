class AddAuctionPassesToInstance < ActiveRecord::Migration[5.0]
  def change
    add_column :instances, :passes, :integer
  end
end
