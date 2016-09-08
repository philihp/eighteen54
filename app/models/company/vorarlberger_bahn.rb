module Company
  class VorarlbergerBahn < ::Company::Company

    def set_defaults
      super
    end

    def name
      'Vorarlberger Bahn'
    end

    def stations
      3
    end

    def home
      'Bregenz'
    end

  end
end
