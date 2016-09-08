module Company
  class SalzburgerBahn < ::Company::Company

    def set_defaults
      super
    end

    def name
      'Salzburger Bahn'
    end

    def stations
      3
    end

    def home
      'Salzburg'
    end

    def charter_type
      :major
    end

  end
end
