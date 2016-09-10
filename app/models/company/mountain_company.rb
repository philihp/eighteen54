module Company
  class MountainCompany < ::Company::Company

    # scope :mountain, -> do
    #   where(type: [
    #     Company::Ausserfernbahn.name,
    #     Company::Murtalbahn.name,
    #     Company::GrazKoflacherBahn.name,
    #     Company::Arlbergbahn.name,
    #     Company::Semmeringbahn.name,
    #   ])
    # end

    def charter_type
      :mountain
    end

    def create_certificates!
      self.certificates << Certificate.create(instance: instance, company: self, percent: 100)
    end

  end
end
