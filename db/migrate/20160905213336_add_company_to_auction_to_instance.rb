class AddCompanyToAuctionToInstance < ActiveRecord::Migration[5.0]
  def change
    add_reference :instances, :company_to_auction, foreign_key: {to_table: :companies}
  end
end
