module Company
  class KernhoferBahn < ::Company::Company

    def name
      'Kernhofer Bahn'
    end

    def set_defaults
      super
      self.cost = 150
    end

    def charter_type
      :local
    end

  end
end
