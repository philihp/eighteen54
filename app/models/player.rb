class Player < ApplicationRecord

  belongs_to :instance

  has_many :bids

  has_many :directorships,
           class_name: 'Company::Company',
           foreign_key: 'director_id'

  has_many :certificates,
           inverse_of: :player

  # A player can only have one optioned share, and if they do then it
  # has to be the next share they buy.
  belongs_to :optioned_share,
             class_name: 'Certificate',
             optional: true

  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.wallet ||= 0
  end

  def can_bid_on(company)
    existing_bid = self.bids.where(company: company).first.try(:amount) || 0
    company.minimum_bid <= existing_bid + self.wallet
  end

  def can_set_par?(company)
    return false unless company.cost.nil?
    return false if self.wallet <= Company::MajorCompany::PAR_VALUES.first * 4
    return true
  end

  def can_buy_share?(company)
    share = company.first_unowned_share
    share.try(:cost).present? && self.wallet > share.cost
  end

end
