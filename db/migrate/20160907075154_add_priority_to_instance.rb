class AddPriorityToInstance < ActiveRecord::Migration[5.0]
  def change
    add_reference :instances, :priority, foreign_key: {to_table: :players}
  end
end
