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

  COLORS = %w(hsla(170,44%,69%,0.75) hsla(60,100%,85%,0.75) hsla(248,30%,79%,0.75) hsla(6,94%,72%,0.75) hsla(205,49%,66%,0.75) hsla(32,97%,69%,0.75) hsla(82,64%,64%,0.75))

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

  def can_option_share?(company)
    share = company.first_unowned_share
    share.try(:cost).present? && self.wallet > share.cost / 2
  end

  def must_buy_option?(company)
    self.optioned_share.try(:company) == company
  end

end
