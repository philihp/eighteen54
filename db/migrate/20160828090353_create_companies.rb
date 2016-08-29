class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.references :instance, foreign_key: true
      t.string :type
      t.timestamps
    end
  end
end
