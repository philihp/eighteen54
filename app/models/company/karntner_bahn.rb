module Company
  class KarntnerBahn < ::Company::Company

    def set_defaults
      super
    end

    def name
      'Kärntner Bahn'
    end

    def stations
      3
    end

    def home
      'Klagenfurt'
    end

  end
end
