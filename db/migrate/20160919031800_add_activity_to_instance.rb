class AddActivityToInstance < ActiveRecord::Migration[5.0]
  def change
    add_column :instances, :activity, :integer
  end
end
