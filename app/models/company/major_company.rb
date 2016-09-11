module Company
  class MajorCompany < ::Company::Company

    PAR_VALUES = [67,72,77,82,87,93].sort

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

    def charter_type
      :major
    end

    def create_certificates!
      self.certificates << Certificate.create(instance: instance, company: self, percent: 40)
      self.certificates << Certificate.create(instance: instance, company: self, percent: 20)
      self.certificates << Certificate.create(instance: instance, company: self, percent: 20)
      self.certificates << Certificate.create(instance: instance, company: self, percent: 20)
    end

    def par_value
      # In the context of a Major, `cost` is the par value.
      self.cost
    end

    def floats?
      percent_owned >= 50
    end

    def percent_owned
      certificates.owned.reduce(0) { |sum, c| sum + c.effective_percent }
    end

    def first_unowned_share
      certificates.unowned.first
    end

  end
end
