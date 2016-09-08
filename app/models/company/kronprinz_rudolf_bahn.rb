module Company
  class KronprinzRudolfBahn < ::Company::Company

    def set_defaults
      super
    end

    def name
      'Kronprinz Rudolf-Bahn'
    end

    def stations
      4
    end

    def home
      'Linz'
    end

  end
end
