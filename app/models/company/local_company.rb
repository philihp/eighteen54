module Company
  class LocalCompany < Company

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

    def charter_type
      :local
    end

    def create_certificates!
      self.certificates << Certificate.build(instance: instance, company: self, percent: 100)
    end

  end
end
