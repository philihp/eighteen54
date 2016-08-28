class AddActivePlayerToInstance < ActiveRecord::Migration[5.0]
  def change
    add_column :instances, :active_player_id, :integer
  end
end
