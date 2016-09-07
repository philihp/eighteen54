class Bid < ApplicationRecord
  belongs_to :company, class_name: 'Company::Company'
  belongs_to :player

  def is_high_bid?
    self.company.bids.first == self
  end

end
