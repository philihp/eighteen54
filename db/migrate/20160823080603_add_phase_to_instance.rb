class AddPhaseToInstance < ActiveRecord::Migration[5.0]
  def change
    add_column :instances, :phase, :integer
  end
end
