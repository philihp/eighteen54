class Player < ApplicationRecord

  belongs_to :instance

  has_many :bids

  has_many :directorships,
           class_name: 'Company::Company',
           foreign_key: 'director_id'

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
    return false unless company.director.nil?


    # PAR_VALUES = [67,72,77,82,87,93]
    return false if self.wallet <= 67 * 4
    return true
  end

end
