class AddNameToInstance < ActiveRecord::Migration[5.0]
  def change
    add_column :instances, :name, :string
  end
end
