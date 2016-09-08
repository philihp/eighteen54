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

    # these are kinda weird with module/scope
    #
    # scope :mountain, -> do
    #   where(type: [
    #     Company::Ausserfernbahn.name,
    #     Company::Murtalbahn.name,
    #     Company::GrazKoflacherBahn.name,
    #     Company::Arlbergbahn.name,
    #     Company::Semmeringbahn.name,
    #   ])
    # end
    #
    # scope :local, -> do
    #   where(type: [
    #     Company::Mariazellerbahn.name,
    #     Company::KernHoferbahn.name,
    #     Company::YbbstalerBahn.name,
    #     Company::Steyrtalbahn.name,
    #     Company::Phyrnbahn.name,
    #     Company::Salzkammergutbahn.name,
    #   ])
    # end
    #
    # scope :major, -> do
    #   where(type: [
    #     Company::KaiserinElisabethWestbahn.name,
    #     Company::KaiserFranzJosephBahn.name,
    #     Company::Sudbahn.name,
    #     Company::KronprinzRudolfBahn.name,
    #     Company::KarntnerBahn.name,
    #     Company::SalzburgerBahn.name,
    #     Company::NordtirolerStaatsbahn.name,
    #     Company::VorarlbergerBahn.name,
    #   ])
    # end

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
