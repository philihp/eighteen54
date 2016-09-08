class CreateCertificates < ActiveRecord::Migration[5.0]
  def change
    create_table :certificates do |t|
      t.belongs_to :player
      t.belongs_to :company
      t.belongs_to :instance
      t.references :sold_by, foreign_key: {to_table: :players}
      t.integer :percent
      t.timestamps
    end

    add_column :companies, :par_value, :integer
    add_column :companies, :treasury, :integer

    add_reference :players, :optioned_share, foreign_key: {to_table: :certificates}
    add_column :players, :option_price, :integer
  end
end
