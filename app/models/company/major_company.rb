module Company
  class MajorCompany < Company

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
      # In the context of a Major, `cost` is the par value.
      self.cost ||= nil
    end

  end
end
