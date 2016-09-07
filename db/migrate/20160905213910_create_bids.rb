class CreateBids < ActiveRecord::Migration[5.0]
  def change
    create_table :bids do |t|
      t.belongs_to :player
      t.belongs_to :company
      t.integer :amount
      t.timestamps
    end
  end
end
