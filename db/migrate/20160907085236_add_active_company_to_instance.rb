class AddActiveCompanyToInstance < ActiveRecord::Migration[5.0]
  def change
    add_reference :instances, :active_company, foreign_key: {to_table: :companies}
  end
end
