class Player < ApplicationRecord
  belongs_to :instance
  has_many :bids

  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.wallet ||= 0
  end

  def can_bid_on(company)
    existing_bid = self.bids.where(company: company).first.try(:amount) || 0
    company.minimum_bid <= existing_bid + self.wallet
  end

end
