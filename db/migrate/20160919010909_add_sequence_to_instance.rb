class AddSequenceToInstance < ActiveRecord::Migration[5.0]
  def change
    add_column :instances, :sequence, :integer
  end
end
