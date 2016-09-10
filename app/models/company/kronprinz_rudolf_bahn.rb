module Company
  class KronprinzRudolfBahn < MajorCompany

    def set_defaults
      super
    end

    def name
      'Kronprinz Rudolf-Bahn'
    end

    def abbr
      'KR'
    end

    def stations
      4
    end

    def home
      'Linz'
    end

    def color
      'palegreen'
    end

    def charter_type
      :major
    end

  end
end
