class AddValueSetAtSequenceToCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :value_set_at_sequence, :integer
  end
end
