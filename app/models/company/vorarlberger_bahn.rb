module Company
  class VorarlbergerBahn < MajorCompany

    def set_defaults
      super
    end

    def name
      'Vorarlberger Bahn'
    end

    def abbr
      'VB'
    end

    def color
      'yellow'
    end

    def stations
      3
    end

    def home
      'Bregenz'
    end

  end
end
