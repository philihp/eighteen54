module Company
  class KernhoferBahn < LocalCompany

    def name
      'Kernhofer Bahn'
    end

    def set_defaults
      super
      self.cost = 150
    end

  end
end
