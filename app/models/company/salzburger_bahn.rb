module Company
  class SalzburgerBahn < Major

    def set_defaults
      super
    end

    def name
      'Salzburger Bahn'
    end

    def abbr
      'SB'
    end

    def color
      'crimson'
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
