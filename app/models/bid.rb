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
    self.player.instance.bank += self.amount
    self.player.instance.save
    certificate.save
    self.destroy
  end

end
