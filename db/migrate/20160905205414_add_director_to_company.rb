class AddDirectorToCompany < ActiveRecord::Migration[5.0]
  def change
    add_reference :companies, :director, foreign_key: {to_table: :players}
  end
end
