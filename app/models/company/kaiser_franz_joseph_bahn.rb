module Company
  class KaiserFranzJosephBahn < MajorCompany

    def set_defaults
      super
    end

    def name
      'Kaiser Franz Joseph-Bahn'
    end

    def abbr
      'FJ'
    end

    def color
      'tan'
    end

    def stations
      3
    end

    def home
      'Wien'
    end

    def charter_type
      :major
    end

  end
end
