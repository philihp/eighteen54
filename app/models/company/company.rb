module Company
  class Company < ApplicationRecord

    belongs_to :instance
    belongs_to :director,
               class_name: 'Player',
               optional: true
    has_many :bids,
             -> { order(amount: :desc) },
             class_name: 'Bid'


      after_initialize :set_defaults, unless: :persisted?

    # enum name: {
    #   'Außerfernbahn': 1,
    #   'Murtalbahn': 2,
    #   'Graz-Köflacher Bahn': 3,
    #   'Arlbergbahn': 4,
    #   'Semmeringbahn': 5,
    #   'Local 1': 6,
    #   'Local 2': 7,
    #   'Local 3': 8,
    #   'Local 4': 9,
    #   'Local 5': 10,
    #   'Local 6': 11,
    #   'Kaiserin Elisabeth-Westbahn': 12,
    #   'Kaiser Franz Joseph-Bahn': 13,
    #   'Südbahn Kronprinz Rudolf-Bahn': 14,
    #   'Kärntner Bahn': 15,
    #   'Salzburger Bahn': 16,
    #   'Nord roler Staatsbahn': 17,
    #   'Vorarlberger Bahn': 18,
    #   'Lokalbahn AG A': 19,
    #   'Lokalbahn AG B': 20,
    #   'Lokalbahn AG C': 21,
    # }

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
      instance.unowned_companies.first == self
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
