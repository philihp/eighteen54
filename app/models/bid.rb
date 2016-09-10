class Bid < ApplicationRecord
  belongs_to :company, class_name: 'Company::Company'
  belongs_to :player

  def is_high_bid?
    self.company.bids.first == self
  end

  def execute!
    self.company.director = self.player
    self.company.save
    certificate = self.company.certificates.first
    certificate.player = self.player
    certificate.save
    self.destroy
  end

end
