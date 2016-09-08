module Company
  class Company < ApplicationRecord

    belongs_to :instance

    belongs_to :director,
               class_name: 'Player',
               optional: true

    has_many :bids,
             -> { order(amount: :desc) },
             class_name: 'Bid'

    has_many :certificates,
             class_name: 'Certificate'

    scope :unowned, -> { where(director: nil) }

    after_initialize :set_defaults, unless: :persisted?

    def name
      self.class.name.demodulize
    end

    def set_defaults
      self.tapped = false
      self.cost ||= nil
    end

    def income
      nil
    end

    def buyable?
      instance.companies.unowned.first == self
    end

    def minimum_bid
      (bids.first.try(:amount) || cost) + 5
    end

    def being_auctioned?
      instance.active_company == self
    end

    def has_only_one_bid?
      bids.count == 1
    end

  end
end
