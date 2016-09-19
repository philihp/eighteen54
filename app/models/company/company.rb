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

    after_create :create_certificates!

    enum mail_contract: {
      no_mail_contract: 0,
      small_mail_contract: 1,
      large_mail_contract: 2,
    }

    def name
      self.class.name.demodulize
    end

    def set_defaults
      self.tapped = false
      self.cost ||= nil
      self.mail_contract ||= 0
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

    def remember_round_value!
      self.round_value = value
      self.save
    end

    def value
      0
    end

    def par_value=(i)
      coords = {
        67 => {x: 2, y: 2},
        72 => {x: 2, y: 3},
        77 => {x: 2, y: 4},
        82 => {x: 2, y: 5},
        87 => {x: 2, y: 6},
        93 => {x: 2, y: 7},
      }[i]
      self.value_x = coords[:x]
      self.value_y = coords[:y]
      self.cost = i
    end

    def turn_order
      [0,0,0]
    end

  end
end
