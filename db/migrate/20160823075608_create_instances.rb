class CreateInstances < ActiveRecord::Migration[5.0]
  def change
    create_table :instances do |t|
      t.integer :round

      t.timestamps
    end
  end
end
