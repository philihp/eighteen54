module Company
  class KarntnerBahn < MajorCompany

    def set_defaults
      super
    end

    def name
      'Kärntner Bahn'
    end

    def abbr
      'KT'
    end

    def color
      'gainsboro'
    end

    def stations
      3
    end

    def home
      'Klagenfurt'
    end

  end
end
