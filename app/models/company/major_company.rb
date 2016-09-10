module Company
  class MajorCompany < ::Company::Company

    PAR_VALUES = [67,72,77,82,87,93]

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

  end
end
