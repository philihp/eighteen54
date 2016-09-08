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

    def charter_type
      :major
    end

  end
end
